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
    let baseURL = "https://jisik2n.store"
    var isError = false
    
    func uploadImage(image: UIImage, completionhandler: @escaping (String) -> Void) {
//        if let data = image.jpegData(compressionQuality: 1){
//            print("There were \(data.count) bytes")
//            let bcf = ByteCountFormatter()
//            bcf.allowedUnits = [.useMB] // optional: restricts the units to MB only
//            bcf.countStyle = .file
//            let string = bcf.string(fromByteCount: Int64(data.count))
//            print("formatted result: \(string)")
//        }
        
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
    
    func deleteImage(url: String){
        let fullURL = URL(string: baseURL + "/api/photo")
        let queryString: Parameters = [
            "url": url
        ]
        
        AF.request(fullURL!, method:.delete, parameters: queryString, interceptor:JWTInterceptor()).responseString{
            response in
            switch(response.result){
            case .success(let data):
                print("Image Deleted")
            case .failure(let error):
                print("fail to delete image")
            }
        }
    }
    
    func getImageData(url: String, completionhandler: @escaping (Data?) -> Void){
        AF.request(url).responseData { response in
            switch response.result{
                case .success(let imageData):
                    DispatchQueue.main.async {
                        print("program got profile image successfully")
                        completionhandler(imageData)
                    }
                case .failure(let err):
                    print(err.localizedDescription)
//                    completionhandler(nil)
                }
        }
    }
}
