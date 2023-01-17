////
////  ProfileRepository.swift
////  jisikin-ios
////
////  Created by 김령교 on 2023/01/17.
////
//
//import Foundation
//import Alamofire
//import RxSwift
//struct Profile:Codable{
//    var profileImage:String?
//    var username:String
//    var isMale:Bool
//}
//class ProfileRepository{
//    let baseURL = "http://jisik2n.ap-northeast-2.elasticbeanstalk.com"
//    var isError = false
//    
//    func getAnswersByQuestionID(id:Int,onCompleted:@escaping([AnswerAPI])->()){
//        
//        let fullURL = URL(string:baseURL + "/api/answer/\(id)")
//        AF.request(fullURL!).responseDecodable(of:[AnswerAPI].self){[unowned self]
//            response in
//            switch(response.result){
//            case .success(let data):
//                onCompleted(data)
//            case .failure(let error):
//                debugPrint(error)
//                self.isError = true
//                onCompleted([])
//                
//            }
//        }
//    }
//    func getAnswersByQuestionID(id:Int)->Single<[AnswerAPI]>{
//        let fullURL = URL(string: baseURL + "/api/answer/\(id)")
//        return Single<[AnswerAPI]>.create{
//            single in
//            AF.request(fullURL!,method:.get).responseDecodable(of:[AnswerAPI].self){
//                response in
//                switch(response.result){
//                case .success(let data):
//                    single(.success(data))
//                case .failure(let error):
//                    single(.failure(error))
//                }
//                
//            }
//            return Disposables.create()
//        }
//    }
//    
//    func postNewAnswer(id: Int, contentText: String) {
//        let fullURL = URL(string: baseURL + "/api/answer/\(id)")
//        
//        let queryString: Parameters = [
//            "content": contentText
//        ]
//        
//        let header: HTTPHeaders = [
//            "Content-Type": "application/json",
//            "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "accessToken")!,
//            "RefreshToken": "Bearer " + UserDefaults.standard.string(forKey: "refreshToken")!
//        ]
//        
//        AF.request(fullURL!, method: .post, parameters: queryString, encoding: JSONEncoding.default, headers: header).responseData {
//            response in
//            switch(response.result) {
//            case .success(let data):
//                print("성공")
//                print(String(data: data, encoding: .utf8)!)
//                break
//            case .failure(let error):
//                print("실패")
//                print(error.localizedDescription)
//                break
//            }
//        }
//    }
//    
//    func selectAnswer(id:Int)->Single<String>{
//        let header: HTTPHeaders = [
//            "Content-Type": "application/json",
//            "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "accessToken")!,
//            "RefreshToken": "Bearer " + UserDefaults.standard.string(forKey: "refreshToken")!
//        ]
//        
//        let fullURL = URL(string: baseURL + "/api/answer/\(id)/select/true")
//        return Single<String>.create{
//            single in
//            AF.request(fullURL!,method:.put,headers:header).validate(statusCode:200..<300).responseString{
//                response in
//                switch(response.result){
//                case .success(let data):
//                    single(.success(data))
//                case .failure(let error):
//                    single(.failure(error))
//                }
//                
//            }
//            return Disposables.create()
//        }
//    }
//}
//    
