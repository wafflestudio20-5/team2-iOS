//
//  ModifyProfileUsecase.swift
//  jisikin-ios
//
//  Created by 김령교 on 2023/01/17.
//

import Foundation
import RxSwift
import RxCocoa
class ModifyProfileUsecase{
    let bag = DisposeBag()
    let ProfileRepo = ProfileRepository()
    let PhotoRepo = PhotoRepository()
    
    let answerRepo = AnswerRepository()
    var questions = BehaviorRelay<[QuestionAPI]>(value:[])
    var questionPhotosByQuestionID = BehaviorRelay<[Int:[UIImage]]>(value:[:])
    var answersByQuestionID = BehaviorRelay<[Int:[AnswerAPI]]>(value:[:])
    var answerPhotosByAnswerID = BehaviorRelay<[Int:[UIImage]]>(value:[:])
    
    func getQuestionsAndAnswers(){
        ProfileRepo.getProfile().subscribe(onSuccess: {[weak self]
            data in
            if(self == nil){return}
            self!.questions.accept(data)
            for question in data{
                self!.getAnswersByQuestionID(id: question.id)
            }
        }).disposed(by: bag)
    }
    func getAnswersByQuestionID(id:Int){
        answerRepo.getAnswersByQuestionID(id: id).subscribe(onSuccess: {[weak self]
            data in
            if self == nil{return}
            var answers = self!.answersByQuestionID.value
            answers[id] = data
            self!.answersByQuestionID.accept(answers)
        }).disposed(by: bag)
    }
    
    func modifyProfile(photo: UIImage, username: String, isMale: Bool)->Single<String>{
        photoPath = self.PhotoRepo.uploadImage(imageData: photo).subscribe(onSuccess: {
            result in
            single(.success(result))
        
        }, onError: {
            error in
            single(.failure(error))
        })
        
        return Single<String>.create{single in
            self.ProfileRepo.putAccount(photoPath: photoPath, username: username, isMale: isMale).subscribe(onSuccess: {
                result in
                single(.success(result))
            
            }, onError: {
                error in
                single(.failure(error))
            })
        }
    }
    
}
