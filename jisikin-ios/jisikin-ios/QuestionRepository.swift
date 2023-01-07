//
//  QuestionRepository.swift
//  jisikin-ios
//
//  Created by 박정헌 on 2023/01/07.
//

import Foundation
import Alamofire
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
}
