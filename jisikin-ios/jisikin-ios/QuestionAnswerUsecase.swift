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
    func getQuestionAndAnswersByID(id:Int){
        questionRepo.getQuestionByID(id: id).subscribe(onSuccess: {[weak self]
            data in
            if(self == nil){return}
            var value = self!.questions.value
            if let row = value.firstIndex(where: {$0.id == id}) {
                value[row] = data
            }
            self!.questions.accept(value)
            
            self!.getAnswersByQuestionID(id: data.id)
            
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
    
    func postNewQuestion(titleText: String, contentText: String) {
        questionRepo.postNewQuestion(titleText: titleText, contentText: contentText)
    }
    
    func postNewAnswer(id: Int, contentText: String,handler:@escaping(()->())) {
        answerRepo.postNewAnswer(id: id, contentText: contentText){
            handler()
        }
    }
    func selectAnswer(questionID:Int,answerID:Int)->Single<String>{
        return Single<String>.create{single in
            self.answerRepo.selectAnswer(id: answerID).subscribe(onSuccess: {
                result in
                single(.success(result))
            
            }, onError: {
                error in
                single(.failure(error))
            })
        }
    }
    func agreeAnswer(id:Int,isAgree:Bool)->Single<String>{
        return Single<String>.create{single in
            self.answerRepo.agreeAnswer(id:id, isAgree: isAgree).subscribe(onSuccess: {
                result in
                single(.success(result))
            
            }, onError: {
                error in
                single(.failure(error))
            })
        }
    }
 
    func deleteAnswer(id:Int)->Single<String>{
        return Single<String>.create{single in
            self.answerRepo.deleteAnswer(id: id).subscribe(onSuccess: {
                result in
                single(.success(result))
            
            }, onError: {
                error in
                single(.failure(error))
            })
        }
    }
    
    
    func deleteQuestion(id:Int)->Single<String>{
        return Single<String>.create{single in
            self.questionRepo.deleteQuestion(id: id).subscribe(onSuccess: {
                result in
                single(.success(result))
            
            }, onError: {
                error in
                single(.failure(error))
            })
        }
    }
    
}
