//
//  QuestionAnswerUsecase.swift
//  jisikin-ios
//
//  Created by 박정헌 on 2023/01/09.
//

import Foundation
import RxSwift
import RxCocoa
class QuestionAnswerUsecase{
    let bag = DisposeBag()
    let questionRepo = QuestionRepository()
    let answerRepo = AnswerRepository()
    var questions = BehaviorRelay<[QuestionAPI]>(value:[])
    var questionPhotosByQuestionID = BehaviorRelay<[Int:[UIImage]]>(value:[:])
    var answersByQuestionID = BehaviorRelay<[Int:[AnswerAPI]]>(value:[:])
    var answerPhotosByAnswerID = BehaviorRelay<[Int:[UIImage]]>(value:[:])
    
    func getQuestionsAndAnswers(){
        questionRepo.getQuestionsByLikes().subscribe(onSuccess: {[weak self]
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
    
    
}
