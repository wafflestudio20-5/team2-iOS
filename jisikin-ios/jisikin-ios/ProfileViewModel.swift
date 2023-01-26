//
//  ProfileViewModel.swift
//  jisikin-ios
//
//  Created by 김령교 on 2023/01/17.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
struct ProfileModel{
    var profileImage:BehaviorRelay<UIImage?>
    var username:String
    var isMale:Bool?
    static func requestToModel(request:ProfileRequest)->ProfileModel{
        let profileImage = BehaviorRelay<UIImage?>(value:nil)
        let usecase = ProfileUsecase()
        if let imageURL = request.profileImage{
            print("User has profile image in server")
            usecase.getProfileImage(url: imageURL){data in
                profileImage.accept(UIImage(data:data))
            }
        }
        usecase.profilePhoto.asObservable().subscribe(onNext: {data in
            if let value = data{
                print("ProfileViewModel got the image")
                profileImage.accept(UIImage(data:value))
            }
        }).disposed(by: DisposeBag())
        return ProfileModel(profileImage: profileImage, username:request.username, isMale:request.isMale)
    }
}
class ProfileViewModel{
    var bag = DisposeBag()
    var usecase = ProfileUsecase()
    var profile = BehaviorRelay<ProfileModel?>(value:nil)
    init() {
        usecase.getProfile()
        usecase.profile.asObservable().subscribe(onNext: {[weak self]
            data in
            if let value = data{
                self!.profile.accept(ProfileModel.requestToModel(request: value))
            }
            
        }).disposed(by: bag)
    }
    func getProfile(){
        usecase.getProfile()
    }
    
    func modifyProfile(profileImage: UIImage?, username:String, isMale:Bool, completionHandler:@escaping (ProfileRepository.ModifyError)->Void){
        if let image = profileImage{
            usecase.uploadImage(image: image){[self] photoPath in
                self.usecase.modifyProfile(photoPath: photoPath, username: username, isMale: isMale){error in
                    completionHandler(error)
                }
            }
        }
        else{
            if let imageURL = usecase.profile.value?.profileImage{
                self.usecase.modifyProfile(photoPath: imageURL, username: username, isMale: isMale){error in
                    completionHandler(error)
                }
            }else{
                self.usecase.modifyProfile(photoPath: "", username: username, isMale: isMale){error in
                    completionHandler(error)
                }
            }
        }
    }
    func deleteProfileImage(url: String){
        usecase.deleteProfileImage(url: url)
    }
}
