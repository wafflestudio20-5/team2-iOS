//
//  MyRelatedQuestionUsecase.swift
//  jisikin-ios
//
//  Created by 김령교 on 2023/01/20.
//

import Foundation
import RxSwift
import RxCocoa

class MyRelatedQuestionUsecase{
    let bag = DisposeBag()
    let questionRepo = QuestionRepository()
    let answerRepo = AnswerRepository()
    var myRelatedQuestions = BehaviorRelay<[MyRelatedQuestionResponse]>(value:[])
    var myRelatedQuestionDetail = BehaviorRelay<QuestionDetailAPI?>(value:nil)
    var answersByQuestionID = BehaviorRelay<[Int:[AnswerAPI]]>(value:[:])
    var answerDetail = BehaviorRelay<[AnswerAPI]>(value:[])
    func getMyQuestions(){
        questionRepo.getMyQuestions().subscribe(onSuccess: {[weak self]
            data in
            self!.myRelatedQuestions.accept(data)
        }).disposed(by: bag)
    }
    func getMyAnsweredQuestions(){
        questionRepo.getMyAnsweredQuestions().subscribe(onSuccess: {[weak self]
            data in
            self!.myRelatedQuestions.accept(data)
        }).disposed(by: bag)
    }
    func getMyHeartedQuestions(){
        questionRepo.getMyHeartedQuestions().subscribe(onSuccess: {[weak self]
            data in
            self!.myRelatedQuestions.accept(data)
        }).disposed(by: bag)
    }
    func getQuestionAndAnswersByID(id:Int){
        questionRepo.getQuestionByID(id: id).subscribe(onSuccess: {
            data in
            self.myRelatedQuestionDetail.accept(data)
            
        }).disposed(by: bag)
        answerRepo.getAnswersByQuestionID(id: id).subscribe(onSuccess:{
            data in
            self.answerDetail.accept(data)
        })
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
    func likeQuestion(id:Int)->Single<String>{
        return Single<String>.create{single in
            self.questionRepo.likeQuestion(id: id).subscribe(onSuccess: {
                result in
                single(.success(result))
            
            }, onError: {
                error in
                single(.failure(error))
            })
        }
    }
    
}
