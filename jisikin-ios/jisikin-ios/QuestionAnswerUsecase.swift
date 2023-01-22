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
    var page = 0
    let bag = DisposeBag()
    let questionRepo = QuestionRepository()
    let answerRepo = AnswerRepository()
    var questionSearch = BehaviorRelay<[QuestionSearchAPI]>(value:[])
    var questionDetail = BehaviorRelay<QuestionDetailAPI?>(value:nil)
    var answerDetail = BehaviorRelay<[AnswerAPI]>(value:[])
    func getQuestionsByLikes(){
        page = 0
        questionRepo.getQuestionsByLikes().subscribe(onSuccess: {
            result in
            self.questionSearch.accept(result)
        }).disposed(by: bag)
    }
    func getMoreQuestionsByLikes(){
        page += 1
        questionRepo.getQuestionsByLikes(page:page).subscribe(onSuccess: {
            result in
            var value = self.questionSearch.value
            value.append(contentsOf: result)
            self.questionSearch.accept(value)
        }).disposed(by: bag)
    }
    func getQuestionsByDate(){
        page = 0
        questionRepo.getQuestionsByDate(page:page).subscribe(onSuccess: {
            result in
            self.questionSearch.accept(result)
        }).disposed(by: bag)
    }
    func getMoreQuestionsByDate(){
        page += 1
        questionRepo.getQuestionsByDate(page:page).subscribe(onSuccess: {
            result in
            var value = self.questionSearch.value
            value.append(contentsOf: result)
            self.questionSearch.accept(value)
        }).disposed(by: bag)
    }
    
    func getQuestionAndAnswersByID(id:Int){
        questionRepo.getQuestionByID(id: id).subscribe(onSuccess: {
            data in
            self.questionDetail.accept(data)
            
        }).disposed(by: bag)
        answerRepo.getAnswersByQuestionID(id: id).subscribe(onSuccess:{
            data in
            self.answerDetail.accept(data)
        })
    }
    
    func searchQuestions(keyword:String){
        questionRepo.searchQuestions(keyword:keyword).subscribe(onSuccess: {
            result in
            self.questionSearch.accept(result)
        }).disposed(by: bag)
    }
   
    func postNewQuestion(titleText: String, contentText: String, tag: [String], photos: [UIImage]) {
        questionRepo.postNewQuestion(titleText: titleText, contentText: contentText, tag: tag, photos: photos)
    }
    
    func postNewAnswer(id: Int, contentText: String, photos: [UIImage], completionhandler: @escaping ((String) -> Void)) {
        answerRepo.postNewAnswer(id: id, contentText: contentText, photos: photos){
            result in
            completionhandler(result)
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
