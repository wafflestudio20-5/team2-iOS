//
//  ProfileRepository.swift
//  jisikin-ios
//
//  Created by 김령교 on 2023/01/17.
//

import Foundation
import Alamofire
import RxSwift
import SwiftyJSON
struct ProfileRequest:Codable{
    var profileImage:String?
    var username:String
    var isMale:Bool?
}
class ProfileRepository{
    let baseURL = "http://jisik2n.ap-northeast-2.elasticbeanstalk.com"
    var isError = false
    
    func getProfile()->Single<ProfileRequest>{
        let fullURL = URL(string: baseURL + "/api/user/myAllProfile/")
        
//        AF.request(fullURL!,method:.get, headers: header).responseJSON { response in
//                    print(response)
//                }
        
        return Single<ProfileRequest>.create{
            single in
            AF.request(fullURL!,method:.get, interceptor:JWTInterceptor()).responseDecodable(of:ProfileRequest.self){
                response in
                switch(response.result){
                case .success(let data):
                    print(data)
                    single(.success(data))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    func putAccount(photoPath: String, username: String, isMale: Bool) ->Single<ProfileRequest> {
        print(photoPath, username, isMale)
        let fullURL = URL(string: baseURL + "/api/user/putAccount")
        let queryString: Parameters = [
                "profileImage": photoPath,
                "username": username,
                "isMale": isMale
            ]
        
        return Single<ProfileRequest>.create{
            single in
            AF.request(fullURL!,method:.put, parameters: queryString, encoding: JSONEncoding.default, interceptor:JWTInterceptor()).validate(statusCode:200..<300).responseDecodable(of:ProfileRequest.self){
                response in
                switch(response.result){
                case .success(let data):
                    single(.success(data))
                case .failure(let error):
                    print(error)
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
}
    
