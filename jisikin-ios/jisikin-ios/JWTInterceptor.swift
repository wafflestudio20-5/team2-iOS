//
//  JWTInterceptor.swift
//  jisikin-ios
//
//  Created by 박정헌 on 2023/01/18.
//
//참고: https://ios-development.tistory.com/730
import Foundation
import Alamofire
class JWTInterceptor:RequestInterceptor{
    let loginRepo = LoginRepository()
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        if let accessToken = UserDefaults.standard.string(forKey: "accessToken") , let refreshToken = UserDefaults.standard.string(forKey: "refreshToken"){
            urlRequest.headers.add(name: "Authorization", value: "Bearer " + accessToken)
            urlRequest.headers.add(name: "RefreshToken",value:"Bearer " + refreshToken)
        }
        else{
            urlRequest.headers.add(name: "Authorization", value: "")
            urlRequest.headers.add(name: "RefreshToken",value:"")
        }
        completion(.success(urlRequest))

    }
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
       
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401 else {
          
                 completion(.doNotRetryWithError(error))
                 return
             }
        loginRepo.regenerateToken{ result in
          
            if result == "success"{
                print("retry")
                completion(.retry)
            }
            else{
                completion(.doNotRetry)
            }
            
        }
        
    }
}
