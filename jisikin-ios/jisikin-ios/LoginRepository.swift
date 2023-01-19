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
    let baseURL = "http://jisik2n.ap-northeast-2.elasticbeanstalk.com"
    var fullURL : URL?
    struct Error {
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
                    self.error.uidWrong = false
                    self.error.passwordWrong = false
                    
                    let asJSON = try JSONSerialization.jsonObject(with: data)
                    
                    let JSON = JSON(data)
                    
                    UserDefaults.standard.set(JSON["username"].string!, forKey: "username")
                    UserDefaults.standard.set(JSON["accessToken"].string!, forKey: "accessToken")
                    UserDefaults.standard.set(JSON["refreshToken"].string!, forKey: "refreshToken")
                    
                    completionHandler("success")
                    } catch {
                        self.errorMessage = String(data: data, encoding: .utf8)
                        
                        let errorCode = Int(response.response!.statusCode)
                        
                        if(errorCode == 401){
                            self.error.uidWrong = false
                            self.error.passwordWrong = true
                        }
                        
                        if(errorCode == 404){
                            self.error.uidWrong = true
                            self.error.passwordWrong = false
                        }
                        
                        completionHandler("error")
                    }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func logout(completionHandler:@escaping (String)->Void) {
        
        if(UserDefaults.standard.bool(forKey: "kakaoLogin") == true){
            UserApi.shared.logout {(error) in
                if let error = error {
                    print(error)
                }
                else {
                    UserDefaults.standard.set(false, forKey: "kakaoLogin")
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
                UserDefaults.standard.removeObject(forKey: "accessToken")
                UserDefaults.standard.removeObject(forKey: "refreshToken")
                completionHandler("success")
            case .failure(let error):
                print(error)
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
                    completionHandler("error")
                } else {
                    let kakaoAccessToken = oauthToken?.accessToken
                    self.sendKakaoToken(token: kakaoAccessToken!, completionHandler: { completion in
                        
                        if(completion == "success"){
                            UserDefaults.standard.set(true, forKey: "kakaoLogin")
                            completionHandler("success")
                        }
                        
                        else{
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
                    completionHandler("error")
                } else {
                    let kakaoAccessToken = oauthToken?.accessToken
                    self.sendKakaoToken(token: kakaoAccessToken!, completionHandler: { completion in
                        
                        if(completion == "success"){
                            UserDefaults.standard.set(true, forKey: "kakaoLogin")
                            completionHandler("success")
                        }
                        
                        else{
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
                    
                    completionHandler("success")
                    } catch {
                        self.errorMessage = String(data: data, encoding: .utf8)
                        
                        print(self.errorMessage!)
                        
                        self.kakaoError = true
                        
                        completionHandler("error")
                    }
                
            case .failure(let error):
                print(error)
                
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
                                self.error.usernameExists = true
                                self.error.uidExists = false
                            }
                            
                            if(self.errorMessage == "이미 가입한 아이디입니다."){
                                self.error.usernameExists = false
                                self.error.uidExists = true
                            }
                        }
                        
                        completionHandler("error")
                    }
                
            case .failure(let error):
                print(error)
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
                    let asJSON = try JSONSerialization.jsonObject(with: data)
                    
                    let JSON = JSON(data)
                    print(JSON)
                    UserDefaults.standard.set(JSON["accessToken"].string!, forKey: "accessToken")
                    UserDefaults.standard.set(JSON["refreshToken"].string!, forKey: "refreshToken")
                    
                    completionHandler("success")
                    } catch {
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
