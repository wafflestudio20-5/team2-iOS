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
        var profileImage = BehaviorRelay<UIImage?>(value:nil)
        ProfileUsecase().profilePhoto.asObservable().subscribe(onNext: {data in
            if let value = data{
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
        usecase.profile.asObservable().subscribe(onNext: {[weak self]
            data in
            if let value = data{
                self!.profile.accept(ProfileModel.requestToModel(request: value))
            }
            
        }).disposed(by: bag)
//        usecase.profilePhoto.asObservable().subscribe(onNext: {[weak self]
//            data in
//            self!.profile.accept(QuestionDetailModel.fromQuestionAPI(questionAPI:data))
//        }).disposed(by: bag)
    }
    func getProfile(){
        usecase.getProfile()
    }
    
    func modifyProfile(profileImage: UIImage, username:String, isMale:Bool){
        usecase.modifyProfile(photo: profileImage, username: username, isMale: isMale)
    }
    
//    func selectAnswer(index:Int)->Single<String>{
//        return Single<String>.create{single in
//            self.usecase.selectAnswer(questionID: self.questionID, answerID: self.answers.value[index].id).subscribe(onSuccess: {
//                result in
//                single(.success(result))
//
//            }, onFailure: {
//                error in
//                single(.failure(error))
//            })
//        }
//
//    }
}
