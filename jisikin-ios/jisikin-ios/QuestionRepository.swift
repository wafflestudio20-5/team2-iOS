//
//  QuestionRepository.swift
//  jisikin-ios
//
//  Created by 박정헌 on 2023/01/07.
//

import Foundation
import Alamofire
import RxSwift
struct QuestionSearchAPI:Codable{
    var questionId:Int
    var title:String
    var content:String
    var answerContent:String?
    var answerCount:Int
    var questionLikeCount:Int
    
}
struct QuestionDetailAPI:Codable{
    var id:Int
    var title:String
    var content:String
    var tag:[String]
    var username:String
    var profileImagePath: String?
    var photos: [String]
    var answerNumber: Int
    var createdAt: String
     var  modifiedAt: String
    var close: Bool
    var closedAt: String?
    var userQuestionLikeNumber:Int
}
final class QuestionRepository{
    let baseURL = "http://jisik2n.ap-northeast-2.elasticbeanstalk.com"
    var isError = false
    
    func postNewQuestion(titleText: String, contentText: String) {
        let fullURL = URL(string: baseURL + "/api/question/")
        
        let queryString: Parameters = [
            "title": titleText,
            "content": contentText
        ]
        
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "accessToken")!,
            "RefreshToken": "Bearer " + UserDefaults.standard.string(forKey: "refreshToken")!
        ]
        
        AF.request(fullURL!, method: .post, parameters: queryString, encoding: JSONEncoding.default, interceptor:JWTInterceptor()).validate(statusCode:200..<300).responseData {
            response in
            switch(response.result) {
            case .success(let data):
                print("성공")
                print(String(data: data, encoding: .utf8)!)
                break
            case .failure(let error):
                print("실패")
                print(error.localizedDescription)
                break
            }
        }
    }
    
    
  
    func getQuestionsByLikes()->Single<[QuestionSearchAPI]>{
        let fullURL = URL(string: baseURL + "/api/question/search")
        
        return Single<[QuestionSearchAPI]>.create{
            single in
            AF.request(fullURL!,method:.get,interceptor:JWTInterceptor()).validate(statusCode:200..<300).responseDecodable(of:[QuestionSearchAPI].self){
                response in
                switch(response.result){
                case .success(let data):
                    var val = data
                  //  for (i,v) in val.photos.enumerated(){
                   //     val[i].photos.append("https://via.placeholder.com/150")
                   //     val[i].photos.append("https://via.placeholder.com/150")
                   //     val[i].photos.append("https://via.placeholder.com/150")
                   // }
                    single(.success(val))
                case .failure(let error):
                    single(.failure(error))
                }
            
            }
            return Disposables.create()
        }
    }
    func getQuestionByID(id:Int)->Single<QuestionDetailAPI>{
        let fullURL = URL(string: baseURL + "/api/question/\(id)")
        return Single<QuestionDetailAPI>.create{
            single in
            AF.request(fullURL!,method:.get,interceptor:JWTInterceptor()).validate(statusCode:200..<300).responseDecodable(of:QuestionDetailAPI.self){
                response in
                switch(response.result){
                case .success(let data):
                    var v = data
                 //   v.photos.append("https://via.placeholder.com/150")
                 //   v.photos.append("https://via.placeholder.com/150")
                 //   v.photos.append("https://via.placeholder.com/1500")
                 
                    single(.success(v))
                case .failure(let error):
                    single(.failure(error))
                }
            
            }
            return Disposables.create()
        }
    }
    func deleteQuestion(id:Int)->Single<String>{
        let fullURL = URL(string:baseURL + "/api/question/\(id)")
        return Single<String>.create{
            single in
            AF.request(fullURL!,method:.delete,interceptor:JWTInterceptor()).validate(statusCode:200..<300).responseString{
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
    func likeQuestion(id:Int)->Single<String>{
        let fullURL = URL(string:baseURL + "/api/questionLike/\(id)/like")
        return Single<String>.create{
            single in
            AF.request(fullURL!,method:.put,interceptor:JWTInterceptor()).validate(statusCode:200..<300).responseString{
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
