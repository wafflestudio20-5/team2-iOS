//
//  ProfileUsecase.swift
//  jisikin-ios
//
//  Created by 김령교 on 2023/01/17.
//

import Foundation
import RxSwift
import RxCocoa
class ProfileUsecase{
    let bag = DisposeBag()
    let ProfileRepo = ProfileRepository()
    let PhotoRepo = PhotoRepository()
    var profile = BehaviorRelay<ProfileRequest?>(value:nil)
    var profilePhoto = BehaviorRelay<Data?>(value:nil)
    
    func getProfile(){
        ProfileRepo.getProfile().subscribe(onSuccess: {[weak self]
            data in
            self!.profile.accept(data)
        }).disposed(by: bag)
    }
    
    func getProfileImage(url: String){
        PhotoRepo.getImageData(url: url).subscribe(onSuccess:{[weak self]
            data in
            print("usecase got image successfully")// 여기서부터 안됨
            self!.profilePhoto.accept(data)
        }).disposed(by: bag)
    }
    
    func uploadImage(image: UIImage, completionhandler: @escaping ((String) -> Void)) {
        PhotoRepo.uploadImage(image: image){
            result in
            completionhandler(result)
        }
    }
    
    func deleteProfileImage(url: String){
        PhotoRepo.deleteImage(url: url)
    }
    
    func modifyProfile(photoPath: String, username: String, isMale: Bool){//->Single<String>{
//        photoPath = self.PhotoRepo.uploadImage(imageData: photo).subscribe(onSuccess: {
//            result in
//            single(.success(result))
//
//        }, onError: {
//            error in
//            single(.failure(error))
//        })
//
//        return Single<String>.create{single in
//            self.ProfileRepo.putAccount(photoPath: photoPath, username: username, isMale: isMale).subscribe(onSuccess: {
//                result in
//                single(.success(result))
//
//            }, onError: {
//                error in
//                single(.failure(error))
//            })
//        }
        ProfileRepo.putAccount(photoPath: photoPath,username: username, isMale: isMale).subscribe(onSuccess: {[weak self] data in
            if(self == nil){
                return
            }
            else{
                print(data)
            }
        })
    }
    
}
