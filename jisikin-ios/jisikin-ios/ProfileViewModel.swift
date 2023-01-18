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
struct ProfileDetailModel{
    var profileImage:UIImage?
    var username:String
    var isMale:Bool?
}
class ProfileViewModel{
    var bag = DisposeBag()
    var usecase = ProfileUsecase()
//    var data:BehaviorRelay<Profile>
    
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
