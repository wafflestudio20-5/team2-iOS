//
//  AnswerRepository.swift
//  jisikin-ios
//
//  Created by 박정헌 on 2023/01/07.
//

import Foundation
import Alamofire
struct AnswerAPI:Codable{
    var content:String
    var photos:[String]
    var createdAt:String
    var selected:Bool
    var selectedAt:String?
    var username:String
    var profileImagePath:String?
    var userRecentAnswerDate:String
}
class AnswerRepository{
    let baseURL = "http://jisik2n.ap-northeast-2.elasticbeanstalk.com"
    var isError = false
    
    func getAnswersByQuestionID(id:Int,onCompleted:@escaping([AnswerAPI])->()){
        
        let fullURL = URL(string:baseURL + "/api/answer/\(id)")
        AF.request(fullURL!).responseDecodable(of:[AnswerAPI].self){[unowned self]
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
}
