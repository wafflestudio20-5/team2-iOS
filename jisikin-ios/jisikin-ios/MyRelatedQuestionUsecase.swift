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
    var page = 0
    var isPageEnded = false
    let ITEM_IN_PAGE = 20
    
    let bag = DisposeBag()
    let questionRepo = QuestionRepository()
    let answerRepo = AnswerRepository()
    var myRelatedQuestions = BehaviorRelay<[MyRelatedQuestionResponse]>(value:[])
    var myRelatedQuestionDetail = BehaviorRelay<QuestionDetailAPI?>(value:nil)
    var answersByQuestionID = BehaviorRelay<[Int:[AnswerAPI]]>(value:[:])
    var answerDetail = BehaviorRelay<[AnswerAPI]>(value:[])
    
    func getMyQuestions(){
        page = 0
        isPageEnded = false
        questionRepo.getMyQuestions(page: page).subscribe(onSuccess: {
            result in
            if result.count < self.ITEM_IN_PAGE{
                self.isPageEnded = true
            }
            self.myRelatedQuestions.accept(result)
        }).disposed(by: bag)
    }
    func getMoreMyQuestions(){
        if isPageEnded{
            return
        }
        page += 1
        questionRepo.getMyQuestions(page:page).subscribe(onSuccess: {
            result in
            if result.count < self.ITEM_IN_PAGE{
                self.isPageEnded = true
            }
            var value = self.myRelatedQuestions.value
            value.append(contentsOf: result)
            self.myRelatedQuestions.accept(value)
        }).disposed(by: bag)
    }
    func getMyAnsweredQuestions(){
        page = 0
        isPageEnded = false
        questionRepo.getMyAnsweredQuestions(page: page).subscribe(onSuccess: {
            result in
            if result.count < self.ITEM_IN_PAGE{
                self.isPageEnded = true
            }
            self.myRelatedQuestions.accept(result)
        }).disposed(by: bag)
    }
    func getMoreMyAnsweredQuestions(){
        if isPageEnded{
            return
        }
        page += 1
        questionRepo.getMyAnsweredQuestions(page:page).subscribe(onSuccess: {
            result in
            if result.count < self.ITEM_IN_PAGE{
                self.isPageEnded = true
            }
            var value = self.myRelatedQuestions.value
            value.append(contentsOf: result)
            self.myRelatedQuestions.accept(value)
        }).disposed(by: bag)
    }
    func getMyHeartedQuestions(){
        page = 0
        isPageEnded = false
        questionRepo.getMyHeartedQuestions(page: page).subscribe(onSuccess: {
            result in
            if result.count < self.ITEM_IN_PAGE{
                self.isPageEnded = true
            }
            self.myRelatedQuestions.accept(result)
        }).disposed(by: bag)
    }
    func getMoreMyHeartedQuestions(){
        if isPageEnded{
            return
        }
        page += 1
        questionRepo.getMyHeartedQuestions(page:page).subscribe(onSuccess: {
            result in
            if result.count < self.ITEM_IN_PAGE{
                self.isPageEnded = true
            }
            var value = self.myRelatedQuestions.value
            value.append(contentsOf: result)
            self.myRelatedQuestions.accept(value)
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
    
    func postNewAnswer(id: Int, contentText: String, photos: [UIImage]) {
        answerRepo.postNewAnswer(id: id, contentText: contentText, photos: photos){
            _ in
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
