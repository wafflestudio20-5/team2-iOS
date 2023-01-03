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
    
    func login(param: Login, completionHandler:@escaping (String)->Void) {
        
        fullURL = URL(string: baseURL + "/api/user/login")
        
        let parameters = [
            "password": param.password,
            "uid": param.ID
        ]
        
        AF.request(fullURL!,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default
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
    
    func kakaoLogin(){
        if (UserApi.isKakaoTalkLoginAvailable()) {
            
            //카톡 설치되어있으면 -> 카톡으로 로그인
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("카카오 톡으로 로그인 성공")
                    
                    let authToken = oauthToken
                    print(authToken)
                }
            }
        }
        
        else {

            // 카톡 없으면 -> 계정으로 로그인
            UserApi.shared.loginWithKakaoAccount { (oauthToken, error) in
                if let error = error {
                    print(error)
                } else {
                    print("카카오 계정으로 로그인 성공")
                    
                    let authToken = oauthToken
                    print(authToken)
                }
            }
        }
    }
    
    func signUp(account: SignUp, completionHandler:@escaping (String)->Void){
        fullURL = URL(string: baseURL + "/api/user/signup")
        
        let parameters = account
        
        AF.request(fullURL!,
                   method: .post,
                   parameters: parameters,
                   encoder: JSONParameterEncoder.default
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
}