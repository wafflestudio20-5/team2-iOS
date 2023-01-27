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
    
    func getProfileImage(url: String, completionhandler: @escaping ((Data) -> Void)){
        PhotoRepo.getImageData(url: url){
            data in
            print("usecase got image successfully")
            UserDefaults.standard.set(data, forKey: "profileImage")
            completionhandler(data)
        }
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
    
    func modifyProfile(photoPath: String, username: String, isMale: Bool,completionHandler:@escaping (ProfileRepository.ModifyError)->Void){
        ProfileRepo.putAccount(photoPath: photoPath,username: username, isMale: isMale, completionHandler: {error in
            completionHandler(error)
        }).subscribe(onSuccess: {[weak self] data in
            if(self == nil){
                return
            }
            else{
                print(data)
            }
        })
    }
    
}
