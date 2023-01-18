//
//  ProfileRepository.swift
//  jisikin-ios
//
//  Created by 김령교 on 2023/01/17.
//

import Foundation
import Alamofire
import RxSwift
struct Profile:Codable{
    var profileImage:String?
    var username:String
    var isMale:Bool
}
class ProfileRepository{
    let baseURL = "http://jisik2n.ap-northeast-2.elasticbeanstalk.com"
    var isError = false
    
    func getProfile()->Single<Profile>{
        let fullURL = URL(string: baseURL + "/api/user/myAllProfile/")
        let parameters: Parameters = [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "accessToken")!
        ]
        return Single<Profile>.create{
            single in
            AF.request(fullURL!,method:.get, parameters: parameters).responseDecodable(of:Profile.self){
                response in
                switch(response.result){
                case .success(let data):
                    single(.success(data))
                case .failure(let error):
                    single(.failure(error))
                }
            
            }
            return Disposables.create()
        }
    }
    
    func putAccount(photoPath: URL, username: String, isMale: Bool) ->Single<String> {
        let fullURL = URL(string: baseURL + "/api/user/putAccount")
        
        let queryString: Parameters = [
            "profileImage": photoPath,
            "username": username,
            "isMale": isMale
        ]
        
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "accessToken")!,
            "RefreshToken": "Bearer " + UserDefaults.standard.string(forKey: "refreshToken")!
        ]
        
        return Single<String>.create{
            single in
            AF.request(fullURL!,method:.put, parameters: queryString, headers:header).validate(statusCode:200..<300).responseString{
                response in
                switch(response.result){
                case .success(let data):
                    single(.success(data))
                case .failure(let error):
                    single(.failure(error))
                }
                
            }
            return Disposables.create()
        }
    }
}
    
