//
//  PhotoRepository.swift
//  jisikin-ios
//
//  Created by 김령교 on 2023/01/18.
//

import Foundation
import Alamofire
import RxSwift
class PhotoRepository{
    let baseURL = "http://jisik2n.ap-northeast-2.elasticbeanstalk.com"
    var isError = false
    
    func uploadImage(image: UIImage, completionhandler: @escaping (String) -> Void) {
        let fullURL = URL(string: baseURL + "/api/photo")
        
        let queryString: Parameters = [
            "image": image.jpegData(compressionQuality: 1)!
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in queryString {
                let uuidName = UUID().uuidString
                multipartFormData.append(value as! Data, withName: "\(key)", fileName: "\(uuidName).jpg", mimeType: "image/jpeg")
            }
            
        }, to: fullURL!, usingThreshold: UInt64.init(), method: .post, interceptor:JWTInterceptor()).responseString { response in
            switch(response.result) {
            case .success(let data):
                print("이미지 업로드 성공")
                print(data)
                completionhandler(data)
            case .failure(let error):
                print("이미지 업로드 실패")
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteImage(url: String) -> Single<String>{
        print("deleteImage에 들어옴")
        return Single<String>.create{single in
            AF.request(url, method:.delete).responseString{
                response in
                switch(response.result){
                case .success(let data):
                    print("Image Deleted")
                    print(data)
                    single(.success(data))
                case .failure(let error):
                    print("fail to delete image")
                    single(.failure(error))
                }
            
            }
            return Disposables.create()
        }
    }
    
    func getImageData(url: String) -> Single<Data> {
        return Single.create { single in
            AF.request(url).responseData { response in
                switch response.result{
                    case .success(let imageData):
                        DispatchQueue.main.async {
                            print("program got profile image successfully")
                            single(.success(imageData))
                        }
                    case .failure(let err):
                        print(err.localizedDescription)
                        single(.success(Data()))
                    }
            }
            return Disposables.create()
        }
    }
}
