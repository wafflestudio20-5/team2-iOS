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
    var questionSearch = BehaviorRelay<[QuestionSearchAPI]>(value:[])
    var questionDetail = BehaviorRelay<QuestionDetailAPI?>(value:nil)
    var answerDetail = BehaviorRelay<[AnswerAPI]>(value:[])
    func getQuestionsByLikes(){
        questionRepo.getQuestionsByLikes().subscribe(onSuccess: {
            result in
            self.questionSearch.accept(result)
        }).disposed(by: bag)
    }
    func getQuestionsByDate(){
        questionRepo.getQuestionsByDate().subscribe(onSuccess: {
            result in
            self.questionSearch.accept(result)
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
   
    func postNewQuestion(titleText: String, contentText: String, tag: [String], photos: [UIImage]) {
        questionRepo.postNewQuestion(titleText: titleText, contentText: contentText, tag: tag, photos: photos)
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
