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
    
    func uploadImage(photos: [UIImage], completionhandler: @escaping ([String]) -> Void) {
        var strImages: [String] = []
        
        let fullURL = URL(string: baseURL + "/api/photo")
        
        var i: Int = 0
        
        if photos.count == 0 {
            completionhandler([])
            return
        }
        
        for image in photos {
            let queryString: Parameters = [
                "image": image.jpegData(compressionQuality: 1)
            ]
            
            AF.upload(multipartFormData: { multipartFormData in
                for (key, value) in queryString {
                    let uuidName = UUID().uuidString
                    multipartFormData.append(value as! Data, withName: "\(key)", fileName: "\(uuidName).jpg", mimeType: "image/jpeg")
                }
                
            }, to: fullURL!, usingThreshold: UInt64.init(), method: .post, interceptor:JWTInterceptor()).responseString { response in
                switch(response.result) {
                case .success(let data):
                    print("이미지 성공")
                    print(data)
                    strImages.append(data)
                    i += 1
                    print("i = " + "\(i)")
                    print("photos.count = " + "\(photos.count)")
                    if i == photos.count {
                        print("completionhandler")
                        completionhandler(strImages)
                    }
                case .failure(let error):
                    print("이미지 실패")
                    print(error.localizedDescription)
                }
            }
            
        }
    }
    
//    func uproadImage(imageData:UIImage?, completion: @escaping (NetworkResult<Any>) -> Void) -> Single<URL>{
//        let fullURL = URL(string: baseURL + "/api/photo/")
//
//        let header: HTTPHeaders = [
//            "Content-Type": "multipart/form-data",
//            "Authorization": "Bearer " + UserDefaults.standard.string(forKey: "accessToken")!,
//            "RefreshToken": "Bearer " + UserDefaults.standard.string(forKey: "refreshToken")!
//        ]
//
//        AF.upload(multipartFormData: { multipartFormData in
//            if let image = imageData?.pngData() {
//                multipartFormData.append(image, withName: "activityImage", fileName: "\(image).png", mimeType: "image/png")
//            }
//        }, to: URL as! URLConvertible, usingThreshold: UInt64.init(), method: .post, headers: header).response { response in
//            guard let statusCode = response.response?.statusCode,
//                  statusCode == 200
//            else { return }
//            completion(.success(statusCode))
//        }
//
////        let image = UIImage.init(named: "myImage")
////        let imgData = image!.jpegData(compressionQuality: 0.2)!
////
////        let parameters = ["name": rname] //Optional for extra parameter
////
////        Alamofire.upload(multipartFormData: { multipartFormData in
////                multipartFormData.append(imgData, withName: "fileset",fileName: "file.jpg", mimeType: "image/jpg")
////                for (key, value) in parameters {
////                        multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
////                    } //Optional for extra parameters
////            },
////        to:"mysite/upload.php")
////        { (result) in
////            switch result {
////            case .success(let upload, _, _):
////
////                upload.uploadProgress(closure: { (progress) in
////                    print("Upload Progress: \(progress.fractionCompleted)")
////                })
////
////                upload.responseJSON { response in
////                     print(response.result.value)
////                }
////
////            case .failure(let encodingError):
////                print(encodingError)
////            }
////        }
//    }
    
    func getImageData(url: String) -> Single<Data> {
        return Single.create { [self] single in
            let realURL = baseURL + url
            AF.request(realURL).responseData { response in
                switch response.result{
                    case .success(let imageData):
                        DispatchQueue.main.async {
                            guard let image = UIImage(data: imageData) else {return}
                            single(.success(imageData))
                            //completionHandler(image)
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
