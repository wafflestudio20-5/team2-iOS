//
//  Repository.swift
//  jisikin-ios
//
//  Created by Chaehyun Park on 2023/01/03.
//

import Alamofire
import SwiftyJSON

final class LoginRepository {
    let baseURL = "http://jisik2n.ap-northeast-2.elasticbeanstalk.com"
    var fullURL : URL?
    struct Error {
        var usernameWrong = false
        var passwordWrong = false
    }
    var error = Error()
    var errorMessage: String?
    var done = false
    
    func login(param: Login, completionHandler:@escaping (String)->Void) {
        //usernameWrong = false
        //passwordWrong = false
        
        //done = false
        
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
                    self.error.usernameWrong = false
                    self.error.passwordWrong = false
                    
                    let asJSON = try JSONSerialization.jsonObject(with: data)
                    
                    let JSON = JSON(data)
                    
                    UserDefaults.standard.set(JSON["accessToken"].string!, forKey: "accessToken")
                    UserDefaults.standard.set(JSON["refreshToken"].string!, forKey: "refreshToken")
                    
                    self.done = true
                    
                    completionHandler("success")
                    } catch {
                        self.errorMessage = String(data: data, encoding: .utf8)
                        
                        let errorCode = Int(response.response!.statusCode)
                        
                        if(errorCode == 401){
                            self.error.usernameWrong = false
                            self.error.passwordWrong = true
                        }
                        
                        if(errorCode == 404){
                            self.error.usernameWrong = true
                            self.error.passwordWrong = false
                        }
                        
                        self.done = true
                        completionHandler("error")
                    }
                
            case .failure(let error):
                print(error)
            }
        }
    }
}
