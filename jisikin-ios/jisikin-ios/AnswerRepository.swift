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
    var interactionCount:InteractionCount
    var userIsAgreed:Bool?
}
struct InteractionCount:Codable{
    var agree:Int
    var disagree:Int
}
class AnswerRepository{
    let baseURL = "https://jisik2n.store"
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
    
    func postNewAnswer(id: Int, contentText: String, photos: [UIImage], completionhandler: @escaping ((String) -> Void)) {
        let fullURL = URL(string: baseURL + "/api/answer/\(id)")
    
        postImage(photos: photos) { [weak self] strImages in
            guard let self = self else { return }
            print("strImage = " + "\(strImages)")
            
            let queryString: Parameters = [
                "content": contentText,
                "photos": strImages
            ]
            
            AF.request(fullURL!, method: .post, parameters: queryString, encoding: JSONEncoding.default, interceptor:JWTInterceptor()).validate(statusCode:200..<300).responseData {
                response in
                switch(response.result) {
                case .success(let data):
                    print("성공")
                    print(String(data: data, encoding: .utf8)!)
                    completionhandler("success")
                    break
                case .failure(let error):
                    print("실패")
                    print(String(data: response.data!, encoding: .utf8)!)
                    completionhandler("failure")
                    break
                }
            }
        }
    }
    
    func editAnswer(id: Int, contentText: String, photos: [UIImage], completionhandler: @escaping ((String) -> Void)) {
        
        let fullURL = URL(string: baseURL + "/api/answer/\(id)")
    
        postImage(photos: photos) { [weak self] strImages in
            guard let self = self else { return }
            print("strImage = " + "\(strImages)")
            
            let queryString: Parameters = [
                "content": contentText,
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
                case .failure(let data):
                    print("실패")
                    print(String(data: response.data!, encoding: .utf8)!)
                    completionhandler("failure")
                    break
                }
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
    func agreeAnswer(id:Int,isAgree:Bool)->Single<String>{
        let fullURL = URL(string:baseURL + "/api/userAnswerInteraction/\(id)/\(isAgree)")
        return Single<String>.create{
            single in
            AF.request(fullURL!,method:.put,interceptor:JWTInterceptor()).validate(statusCode: 200..<300).responseString{
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
    func deleteAnswer(id:Int)->Single<String>{
        let fullURL = URL(string:baseURL + "/api/answer/\(id)")
        return Single<String>.create{
            single in
            AF.request(fullURL!,method:.delete,interceptor:JWTInterceptor()).validate(statusCode: 200..<300).responseString{
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
    
