//
//  Repository.swift
//  jisikin-ios
//
//  Created by Chaehyun Park on 2023/01/03.
//

import Alamofire
import SwiftyJSON
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser

final class LoginRepository {
    let baseURL = "https://jisik2n.store"
    var fullURL : URL?
    struct Error {
        var hadError = false
        var deletedUser = false
        var uidWrong = false
        var passwordWrong = false
        var usernameExists = false
        var uidExists = false
    }
    var error = Error()
    var errorMessage: String?
    var kakaoError: Bool = false
    
    let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": ""
    ]
    
    func login(param: Login, completionHandler:@escaping (String)->Void) {
        
        fullURL = URL(string: baseURL + "/api/user/login")
        
        let parameters = [
            "password": param.password,
            "uid": param.ID
        ]
        
        AF.request(fullURL!,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default,
                   headers: header
        )
        .responseData(){
            response in
            
            switch response.result {
            case .success(let data):
                do {
                    self.error.hadError = false
                    self.error.deletedUser = false
                    self.error.uidWrong = false
                    self.error.passwordWrong = false
                    
                    let asJSON = try JSONSerialization.jsonObject(with: data)
                    
                    let JSON = JSON(data)
                    
                    UserDefaults.standard.set(JSON["username"].string!, forKey: "username")
                    UserDefaults.standard.set(JSON["accessToken"].string!, forKey: "accessToken")
                    UserDefaults.standard.set(JSON["refreshToken"].string!, forKey: "refreshToken")
                    
                    completionHandler("success")
                    } catch {
                        self.error.hadError = true
                        self.errorMessage = String(data: data, encoding: .utf8)
                        
                        let errorCode = Int(response.response!.statusCode)
                        
                        if(errorCode == 401){
                            self.error.deletedUser = false
                            self.error.uidWrong = false
                            self.error.passwordWrong = true
                        }
                        
                        if(errorCode == 404){
                            self.error.deletedUser = false
                            self.error.uidWrong = true
                            self.error.passwordWrong = false
                        }
                        
                        if(errorCode == 403){
                            self.error.deletedUser = true
                            self.error.uidWrong = false
                            self.error.passwordWrong = false
                        }
                        
                        completionHandler("error")
                    }
                
            case .failure(let error):
                self.error.hadError = true
                print(error)
            }
        }
    }
    
    func logout(completionHandler:@escaping (String)->Void) {
        
        if(UserDefaults.standard.bool(forKey: "kakaoLogin") == true){
            UserApi.shared.logout {(error) in
                if let error = error {
                    print(error)
                    self.error.hadError = true
                }
                else {
                    self.error.hadError = false
                    UserDefaults.standard.set(false, forKey: "kakaoLogin")
                    UserDefaults.standard.removeObject(forKey: "username")
                }
            }
        }
        
        fullURL = URL(string: baseURL + "/api/user/logout")
        
        let accessToken = UserDefaults.standard.value(forKey: "accessToken") as? String
        let refreshToken = UserDefaults.standard.value(forKey: "accessToken") as? String
        
        let parameters = [
            "accessToken": accessToken,
            "refreshToken": refreshToken
        ]
        
        AF.request(fullURL!,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default,
                   headers: header
        )
        .responseData(){
            response in
            
            switch response.result {
            case .success(_):
                self.error.hadError = false
                UserDefaults.standard.removeObject(forKey: "accessToken")
                UserDefaults.standard.removeObject(forKey: "refreshToken")
                UserDefaults.standard.removeObject(forKey: "username")
                completionHandler("success")
            case .failure(let error):
                print(error)
                self.error.hadError = true
                completionHandler("failure")
            }
        }
    }
    
    func kakaoLogin(completionHandler:@escaping (String)->Void){
        if (UserApi.isKakaoTalkLoginAvailable()) {
            
            //카톡 설치되어있으면 -> 카톡으로 로그인
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                    self.kakaoError = true
                    self.error.hadError = true
                    completionHandler("error")
                } else {
                    let kakaoAccessToken = oauthToken?.accessToken
                    self.sendKakaoToken(token: kakaoAccessToken!, completionHandler: { completion in
                        
                        if(completion == "success"){
                            self.error.hadError = false
                            UserDefaults.standard.set(true, forKey: "kakaoLogin")
                            completionHandler("success")
                        }
                        
                        else{
                            self.error.hadError = true
                            completionHandler("failure")
                        }
                    })
                }
            }
        }
        
        else {
            // 카톡 없으면 -> 계정으로 로그인
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    print(error)
                    self.kakaoError = true
                    self.error.hadError = true
                    completionHandler("error")
                } else {
                    let kakaoAccessToken = oauthToken?.accessToken
                    self.sendKakaoToken(token: kakaoAccessToken!, completionHandler: { completion in
                        
                        if(completion == "success"){
                            UserDefaults.standard.set(true, forKey: "kakaoLogin")
                            self.error.hadError = false
                            completionHandler("success")
                        }
                        
                        else{
                            self.error.hadError = true
                            completionHandler("failure")
                        }
                    })
                }
            }
        }
    }
    
    func sendKakaoToken(token: String, completionHandler:@escaping (String)->Void){
        fullURL = URL(string: baseURL + "/api/user/kakaoLogin?accessToken=" + token)
        
        AF.request(fullURL!,
                   method: .get,
                   headers: header
        )
        .responseData(){
            response in
            
            switch response.result {
            case .success(let data):
                do {
                    let asJSON = try JSONSerialization.jsonObject(with: data)
                    
                    let JSON = JSON(data)
                    
                    UserDefaults.standard.set(JSON["username"].string!, forKey: "username")
                    UserDefaults.standard.set(JSON["accessToken"].string!, forKey: "accessToken")
                    UserDefaults.standard.set(JSON["refreshToken"].string!, forKey: "refreshToken")
                    
                    self.error.hadError = false
                    completionHandler("success")
                    } catch {
                        self.errorMessage = String(data: data, encoding: .utf8)
                        
                        print(self.errorMessage!)
                        
                        self.kakaoError = true
                        self.error.hadError = true
                        completionHandler("error")
                    }
                
            case .failure(let error):
                print(error)
                self.error.hadError = true
                completionHandler("error")
            }
        }
    }
    
    
    func signUp(account: SignUp, completionHandler:@escaping (String)->Void){
        fullURL = URL(string: baseURL + "/api/user/signup")
        
        let parameters = account
        
        AF.request(fullURL!,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default,
                   headers: header
        )
        .responseData(){
            response in
            
            switch response.result {
            case .success(let data):
                do {
                    self.error.hadError = false
                    self.error.deletedUser = false
                    self.error.uidExists = false
                    self.error.usernameExists = false
                    
                    let asJSON = try JSONSerialization.jsonObject(with: data)
                    
                    let JSON = JSON(data)
                    
                    UserDefaults.standard.set(JSON["accessToken"].string!, forKey: "accessToken")
                    UserDefaults.standard.set(JSON["refreshToken"].string!, forKey: "refreshToken")
                    
                    completionHandler("success")
                    } catch {
                        self.errorMessage = String(data: data, encoding: .utf8)
                        
                        let errorCode = Int(response.response!.statusCode)
                        
                        if(errorCode == 409){
                            if(self.errorMessage == "이미 생성된 별명입니다."){
                                self.error.deletedUser = false
                                self.error.usernameExists = true
                                self.error.uidExists = false
                            }
                            
                            if(self.errorMessage == "이미 가입한 아이디입니다"){
                                self.error.deletedUser = false
                                self.error.usernameExists = false
                                self.error.uidExists = true
                            }
                        }
                        self.error.hadError = true
                        completionHandler("error")
                    }
                
            case .failure(let error):
                print(error)
                self.error.hadError = true
            }
        }
        
    }
    
    func signOut(completionHandler:@escaping (String)->Void){
        let fullURL = URL(string: baseURL + "/api/user/deleteAccount")
        
        if(UserDefaults.standard.bool(forKey: "kakaoLogin") == true){
            UserApi.shared.unlink {(error) in
                if let error = error {
                    print(error)
                    self.error.hadError = true
                }
                else {
                    self.error.hadError = false
                    UserDefaults.standard.set(false, forKey: "kakaoLogin")
                    UserDefaults.standard.removeObject(forKey: "username")
                }
            }
        }
        
        AF.request(fullURL!, method:.delete, interceptor:JWTInterceptor()).responseData(){
            response in
            switch response.result {
            case .success(_):
                self.error.hadError = false
                UserDefaults.standard.removeObject(forKey: "accessToken")
                UserDefaults.standard.removeObject(forKey: "refreshToken")
                UserDefaults.standard.removeObject(forKey: "username")
                completionHandler("success")
            case .failure(let error):
                print(error)
                self.error.hadError = true
                completionHandler("failure")
            }
        }
    }
    
    func regenerateToken(completionHandler:@escaping (String)->Void) {
        fullURL = URL(string: baseURL + "/api/user/regenerateToken")
        
        let accessToken = UserDefaults.standard.value(forKey: "accessToken") as? String
        let refreshToken = UserDefaults.standard.value(forKey: "refreshToken") as? String
        
        let parameters = [
            "accessToken": accessToken,
            "refreshToken": refreshToken
        ]
        print(parameters)
        AF.request(fullURL!,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default,
                   headers: header
        ).validate(statusCode: 200..<300)
        .responseData(){
            response in
            
            switch response.result {
            case .success(let data):
                do {
                    let asJSON = try JSONSerialization.jsonObject(with: data)
                    
                    let JSON = JSON(data)
                    print(JSON)

                    UserDefaults.standard.set(JSON["accessToken"].string ?? "", forKey: "accessToken")
                    UserDefaults.standard.set(JSON["refreshToken"].string ?? "", forKey: "refreshToken")

                    self.error.hadError = false
                    completionHandler("success")
                    } catch {
                        self.error.hadError = true
                        self.errorMessage = String(data: data, encoding: .utf8)
                        print(self.errorMessage)
                        
                        completionHandler("error")
                    }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
