//
//  QuestionRepository.swift
//  jisikin-ios
//
//  Created by 박정헌 on 2023/01/07.
//

import Foundation
import Alamofire
import RxSwift
struct QuestionAPI:Codable{
    var id:Int
    var title:String
    var content:String
    var createdAt:String
    var modifiedAt:String
    var close:Bool
    
    
}
final class QuestionRepository{
    let baseURL = "http://jisik2n.ap-northeast-2.elasticbeanstalk.com"
    var isError = false
    
    func postNewQuestion(titleText: String, contentText: String) {
        let fullURL = URL(string: baseURL + "/api/question")
        
        let queryString: Parameters = [
            "title": titleText,
            "content": contentText
        ]
        
        let header: HTTPHeaders = [
            "Content-Type": "application/json",
            "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "accessToken")!,
            "RefreshToken": "Bearer " + UserDefaults.standard.string(forKey: "refreshToken")!
        ]
        
        AF.request(fullURL!, method: .post, parameters: queryString, encoding: URLEncoding.queryString, headers: header).responseData {
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
    
    
    func getRecentQuestions(onCompleted:@escaping([QuestionAPI])->()){
        let fullURL = URL(string: baseURL + "/api/question/search")
        AF.request(fullURL!,method:.get).responseDecodable(of:[QuestionAPI].self){[unowned self]
            response in
            switch(response.result){
            case .success(let data):
                print(data)
                onCompleted(data)
            case .failure(let error):
                self.isError = true
                onCompleted([])
            }
        }
    }
    func getQuestionsByLikes()->Single<[QuestionAPI]>{
        let fullURL = URL(string: baseURL + "/api/question/search")
        return Single<[QuestionAPI]>.create{
            single in
            AF.request(fullURL!,method:.get).responseDecodable(of:[QuestionAPI].self){
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
