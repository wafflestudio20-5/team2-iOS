//
//  AnswerRepository.swift
//  jisikin-ios
//
//  Created by 박정헌 on 2023/01/07.
//

import Foundation
import Alamofire
import RxSwift
struct AnswerAPI:Codable{
    var content:String
    var photos:[String]
    var createdAt:String
    var selected:Bool
    var selectedAt:String?
    var username:String
    var profileImagePath:String?
    var userRecentAnswerDate:String
    var id:Int
}
class AnswerRepository{
    let baseURL = "http://jisik2n.ap-northeast-2.elasticbeanstalk.com"
    var isError = false
    
    func getAnswersByQuestionID(id:Int,onCompleted:@escaping([AnswerAPI])->()){
        
        let fullURL = URL(string:baseURL + "/api/answer/\(id)")
        AF.request(fullURL!,interceptor:JWTInterceptor()).validate(statusCode:200..<300).responseDecodable(of:[AnswerAPI].self){[unowned self]
            response in
            switch(response.result){
            case .success(let data):
                onCompleted(data)
            case .failure(let error):
                debugPrint(error)
                self.isError = true
                onCompleted([])
                
            }
        }
    }
    func getAnswersByQuestionID(id:Int)->Single<[AnswerAPI]>{
        let fullURL = URL(string: baseURL + "/api/answer/\(id)")
        return Single<[AnswerAPI]>.create{
            single in
            AF.request(fullURL!,method:.get,interceptor:JWTInterceptor()).validate(statusCode:200..<300).responseDecodable(of:[AnswerAPI].self){
                response in
                switch(response.result){
                case .success(let data):
                    var val = (data as! [AnswerAPI])
                    
                    for (i,v) in val.enumerated(){
                     //  val[i].photos.append("https://via.placeholder.com/150")
                     //  val[i].photos.append("https://via.placeholder.com/150")
                     //  val[i].photos.append("https://via.placeholder.com/1500")
                    }
                    single(.success(val))
                    
                case .failure(let error):
                    single(.failure(error))
                }
                
            }
            return Disposables.create()
        }
    }
    
    func postNewAnswer(id: Int, contentText: String,handler:@escaping(()->())) {
        let fullURL = URL(string: baseURL + "/api/answer/\(id)")
        
        let queryString: Parameters = [
            "content": contentText
        ]
        
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "accessToken")!,
            "RefreshToken": "Bearer " + UserDefaults.standard.string(forKey: "refreshToken")!
        ]
        
        AF.request(fullURL!, method: .post, parameters: queryString, encoding: JSONEncoding.default, headers: header,interceptor:JWTInterceptor()).validate(statusCode:200..<300).responseData {
            response in
            switch(response.result) {
            case .success(let data):
                print("성공")
                print(String(data: data, encoding: .utf8)!)
                handler()
                break
            case .failure(let error):
                print("실패")
                print(error.localizedDescription)
                break
            }
        }
    }
    
    func selectAnswer(id:Int)->Single<String>{
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "accessToken")!,
            "RefreshToken": "Bearer " + UserDefaults.standard.string(forKey: "refreshToken")!
        ]
        
        let fullURL = URL(string: baseURL + "/api/answer/\(id)/select/true")
        return Single<String>.create{
            single in
            AF.request(fullURL!,method:.put,headers:header,interceptor:JWTInterceptor()).validate(statusCode:200..<300).responseString{
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
    
