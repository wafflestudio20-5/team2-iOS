//
//  QuestionRepository.swift
//  jisikin-ios
//
//  Created by 박정헌 on 2023/01/07.
//

import Foundation
import Alamofire
import RxSwift
struct MyRelatedQuestionResponse:Codable{
    var id:Int
    var title:String
    var content:String?
    var createdAt:String
    var answerCount:Int?
}
struct QuestionSearchAPI:Codable{
    var questionId:Int
    var title:String
    var content:String
    var answerContent:String?
    var answerCount:Int
    var questionCreatedAt:String
    var questionLikeCount:Int
    var questionTag:[String]
    var photo:String?
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
    var modifiedAt: String
    var close: Bool
    var closedAt: String?
    var userQuestionLikeNumber:Int
}
struct QuestionIDAPI:Codable{
    var id:Int
}
final class QuestionRepository{
    let baseURL = "https://jisik2n.store"
    var isError = false
    
    func postImage(photos: [UIImage], completionhandler: @escaping ([String]) -> Void) {
        var strImages: [String] = []
        
        let fullURL2 = URL(string: baseURL + "/api/photo/content")
        
        if photos.count == 0 {
            completionhandler([])
            return
        }
        
        for _ in 1...photos.count {
            strImages.append("")
        }
        
        for i in 0...(photos.count - 1) {
            let queryString: Parameters = [
                "order": i
            ]
            
            AF.upload(multipartFormData: { multipartFormData in
                for (key, value) in queryString {
                    //print("i = \(i)")
                    multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                }
                if let imageData = photos[i].jpegData(compressionQuality: 1) {
                    let uuidName = UUID().uuidString
                    multipartFormData.append(imageData, withName: "image", fileName: "\(uuidName).jpg", mimeType: "image/jpeg")
                }
                
            }, to: fullURL2!, usingThreshold: UInt64.init(), method: .post, interceptor:JWTInterceptor()).responseJSON { response in
                switch(response.result) {
                case .success(let data):
                    print("이미지 성공")
                    let imageURL: String = (data as AnyObject).object(forKey: "url")! as! String
                    let index: Int = (data as AnyObject).object(forKey: "order")! as! Int
                    
                    //print("url = \(imageURL)")
                    //print("index = \(index)")
                    
                    strImages[index] = imageURL
                    
                    var flag: Bool = true
                    
                    for str in strImages {
                        if str == "" {
                            flag = false
                        }
                    }
                    
                    if flag {
                        print("completionhandler")
                        completionhandler(strImages)
                    }
                    
                case .failure(let error):
                    print("이미지 실패")
                    print(String(data: response.data!, encoding: .utf8)!)
                }
            }
        }
    }
    
    func editQuestion(questionID: Int, titleText: String, contentText: String, tag: [String], photos: [UIImage], completionhandler: @escaping ((String) -> Void)) {
        let fullURL = URL(string: baseURL + "/api/question/\(questionID)")
        
        postImage(photos: photos) { [weak self] strImages in
            guard let self = self else { return }
            // print("strImage = " + "\(strImages)")
            
            let queryString: Parameters = [
                "title": titleText,
                "content": contentText,
                "tag": tag,
                "photos": strImages
            ]
            
            AF.request(fullURL!, method: .put, parameters: queryString, encoding: JSONEncoding.default, interceptor:JWTInterceptor()).validate(statusCode:200..<300).responseData {
                response in
                switch(response.result) {
                case .success(let data):
                    print("성공")
                    print(String(data: data, encoding: .utf8)!)
                    completionhandler("success")
                    break
                case .failure(let error):
                    print("실패")
                    print(error.localizedDescription)
                    completionhandler("failure")
                    break
                }
            }
        }
    }
    
    func postNewQuestion(titleText: String, contentText: String, tag: [String], photos: [UIImage]) {
        let fullURL = URL(string: baseURL + "/api/question/")
    
        postImage(photos: photos) { [weak self] strImages in
            guard let self = self else { return }
            // print("strImage = " + "\(strImages)")
            
            let queryString: Parameters = [
                "title": titleText,
                "content": contentText,
                "tag": tag,
                "photos": strImages
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
    }
    
    func getQuestionsByDate()->Single<[QuestionSearchAPI]>{
        let fullURL = URL(string: baseURL + "/api/question/search")
        let parameters = [
            "order":"date"
        ]
        return Single<[QuestionSearchAPI]>.create{
            single in
            AF.request(fullURL!,method:.get,parameters: parameters,interceptor:JWTInterceptor()).validate(statusCode:200..<300).responseDecodable(of:[QuestionSearchAPI].self){
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

    func getQuestionsByLikes()->Single<[QuestionSearchAPI]>{
        let fullURL = URL(string: baseURL + "/api/question/search")
        let parameters = [
            "order":"like"
        ]
        return Single<[QuestionSearchAPI]>.create{
            single in
            AF.request(fullURL!,method:.get,parameters: parameters,interceptor:JWTInterceptor()).validate(statusCode:200..<300).responseDecodable(of:[QuestionSearchAPI].self){
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
    func getQuestionsByLikes(page:Int)->Single<[QuestionSearchAPI]>{
        let fullURL = URL(string: baseURL + "/api/question/search")
        let parameters = [
            "order":"like",
            "pageNum":page
        ] as [String : Any]
        return Single<[QuestionSearchAPI]>.create{
            single in
            AF.request(fullURL!,method:.get,parameters: parameters,interceptor:JWTInterceptor()).validate(statusCode:200..<300).responseDecodable(of:[QuestionSearchAPI].self){
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
    func getQuestionsByDate(page:Int)->Single<[QuestionSearchAPI]>{
        let fullURL = URL(string: baseURL + "/api/question/search")
        let parameters = [
            "order":"date",
            "pageNum":page
        ] as [String : Any]
        return Single<[QuestionSearchAPI]>.create{
            single in
            AF.request(fullURL!,method:.get,parameters: parameters,interceptor:JWTInterceptor()).validate(statusCode:200..<300).responseDecodable(of:[QuestionSearchAPI].self){
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
    
    func getRandomQuestionID()->Single<QuestionDetailAPI>{
        let fullURL = URL(string: baseURL + "/api/question/random")
        return Single<QuestionDetailAPI>.create{
            single in
            AF.request(fullURL!,method:.get,interceptor:JWTInterceptor()).validate(statusCode:200..<300).responseDecodable(of:QuestionDetailAPI.self){
                response in
                switch(response.result){
                case .success(let data):
                    var v = data
                 
                    single(.success(v))
                case .failure(let error):
                    single(.failure(error))
                }
            
            }
            return Disposables.create()
        }
    }

    func getAdminQuestionID()->Single<QuestionDetailAPI>{
        let fullURL = URL(string: baseURL + "/api/question/admin")
        return Single<QuestionDetailAPI>.create{
            single in
            AF.request(fullURL!,method:.get,interceptor:JWTInterceptor()).validate(statusCode:200..<300).responseDecodable(of:QuestionDetailAPI.self){
                response in
                switch(response.result){
                case .success(let data):
                    var v = data
                 
                    single(.success(v))
                case .failure(let error):
                    single(.failure(error))
                }
            
            }
            return Disposables.create()
        }
    }
    
    func searchQuestions(keyword:String, page:Int)->Single<[QuestionSearchAPI]>{
        let fullURL = URL(string: baseURL + "/api/question/search")
        let parameters = [
            "keyword":keyword,
            "pageNum":page
        ] as [String : Any]
        return Single<[QuestionSearchAPI]>.create{
            single in
            AF.request(fullURL!,method:.get,parameters: parameters,interceptor:JWTInterceptor()).validate(statusCode:200..<300).responseDecodable(of:[QuestionSearchAPI].self){
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
    
    func getMyQuestions(page:Int)->Single<[MyRelatedQuestionResponse]>{
        let fullURL = URL(string: baseURL + "/api/user/myQuestions")
        let parameters = [
            "pageNum":page
        ]
        return Single<[MyRelatedQuestionResponse]>.create{
            single in
            AF.request(fullURL!,method:.get,parameters: parameters, interceptor:JWTInterceptor()).validate(statusCode:200..<300).responseDecodable(of:[MyRelatedQuestionResponse].self){
                response in
                switch(response.result){
                case .success(let data):
                    print(data)
                    single(.success(data))
                case .failure(let error):
                    print(error)
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    func getMyAnsweredQuestions(page:Int)->Single<[MyRelatedQuestionResponse]>{
        let fullURL = URL(string: baseURL + "/api/user/myAnswers/")
        let parameters = [
            "pageNum":page
        ]
        return Single<[MyRelatedQuestionResponse]>.create{
            single in
            AF.request(fullURL!,method:.get, parameters: parameters, interceptor:JWTInterceptor()).responseDecodable(of:[MyRelatedQuestionResponse].self){
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
    func getMyHeartedQuestions(page:Int)->Single<[MyRelatedQuestionResponse]>{
        let fullURL = URL(string: baseURL + "/api/user/myLikeQuestions")
        let parameters = [
            "pageNum":page
        ]
        return Single<[MyRelatedQuestionResponse]>.create{
            single in
            AF.request(fullURL!,method:.get, parameters: parameters, interceptor:JWTInterceptor()).responseDecodable(of:[MyRelatedQuestionResponse].self){
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
    func getLikedQuestionsID()->Single<[QuestionIDAPI]>{
        let fullURL = URL(string:baseURL + "/api/user/myLikeQuestions")
        return Single<[QuestionIDAPI]>.create{
            single in
            AF.request(fullURL!,method:.get,interceptor: JWTInterceptor())
                .validate(statusCode: 200..<300).responseDecodable(of:[QuestionIDAPI].self){
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
