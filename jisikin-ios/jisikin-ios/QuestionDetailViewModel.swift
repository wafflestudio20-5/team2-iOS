//
//  QuestionDetailViewModel.swift
//  jisikin-ios
//
//  Created by 박정헌 on 2023/01/09.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
struct AnswerDetailModel{
    var content:String
    var photos:[String]
    var createdAt:String
    var selected:Bool
    var username:String
    var profileImage:UIImage?
    var userRecentAnswerDate:String
    var id:Int
    var agree:Int
    var disagree:Int
    static func fromAnswerAPI(answerAPI:AnswerAPI)->AnswerDetailModel{
        return AnswerDetailModel(content: answerAPI.content,photos:answerAPI.photos, createdAt:convertTimeFormat(time: answerAPI.createdAt), selected: answerAPI.selected, username: answerAPI.username, userRecentAnswerDate:convertTimeFormat(time: answerAPI.userRecentAnswerDate),id:answerAPI.id,agree:answerAPI.interactionCount.agree,disagree:answerAPI.interactionCount.disagree)
    }
    static func convertTimeFormat(time:String)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        let date = dateFormatter.date(from: time)!
        let relativeFormatter = RelativeDateTimeFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC+9")
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: date)
    }
}
struct QuestionDetailModel{
    var title:String
    var content:String
    var photos:[String]
    var createdAt:String
    var username:String
    var close:Bool
    var likeNumber:Int
    var tag:[String]
    static func fromQuestionAPI(questionAPI:QuestionDetailAPI?)->QuestionDetailModel?{
       
        if let questionAPI = questionAPI{
            return QuestionDetailModel(title: questionAPI.title, content: questionAPI.content,photos:questionAPI.photos, createdAt:convertTimeFormat(time: questionAPI.createdAt),username:questionAPI.username,close:questionAPI.close,likeNumber: questionAPI.userQuestionLikeNumber,tag:questionAPI.tag)
        }
        else{
            return nil
        }
    }
    static func convertTimeFormat(time:String)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        let date = dateFormatter.date(from: time)!
        let relativeFormatter = RelativeDateTimeFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "UTC+9")
        dateFormatter.dateFormat = "yyyy.MM.dd"
        return dateFormatter.string(from: date)
    }
}
class QuestionDetailViewModel{
    var bag = DisposeBag()
    var usecase:QuestionAnswerUsecase
    var questionID:Int
    var question = BehaviorRelay<QuestionDetailModel?>(value:nil)
    var answers = BehaviorRelay<[AnswerDetailModel]>(value:[])
    init(usecase: QuestionAnswerUsecase, questionID: Int) {
        self.usecase = usecase
        self.questionID = questionID
        usecase.questionDetail.asObservable().subscribe(onNext: {[weak self]
            data in
            self!.question.accept(QuestionDetailModel.fromQuestionAPI(questionAPI:data))
            
        }).disposed(by: bag)
        usecase.answerDetail.asObservable().subscribe(onNext:{[weak self]
            data in
            self!.answers.accept(data.map{
                AnswerDetailModel.fromAnswerAPI(answerAPI: $0)
            })        }).disposed(by: bag)
    }
    func refresh(){
        usecase.getQuestionAndAnswersByID(id: questionID)
    }
    func selectAnswer(index:Int)->Single<String>{
        return Single<String>.create{single in
            self.usecase.selectAnswer(questionID: self.questionID, answerID: self.answers.value[index].id).subscribe(onSuccess: {
                result in
                single(.success(result))
                
            }, onFailure: {
                error in
                single(.failure(error))
            })
        }
       
    }
    func agreeAnswer(index:Int,isAgree:Bool)->Single<String>{
        return Single<String>.create{single in
            self.usecase.agreeAnswer(id: self.answers.value[index].id ,isAgree:isAgree ).subscribe(onSuccess: {
                result in
                single(.success(result))
                
            }, onFailure: {
                error in
                single(.failure(error))
            })
        }
       
    }
   
    func deleteAnswer(index:Int)->Single<String>{
        return Single<String>.create{single in
            self.usecase.deleteAnswer(id: self.answers.value[index].id  ).subscribe(onSuccess: {
                result in
                single(.success(result))
                
            }, onFailure: {
                error in
                single(.failure(error))
            })
        }
    }
    func deleteQuestion()->Single<String>{
        return Single<String>.create{single in
            self.usecase.deleteQuestion(id:self.questionID).subscribe(onSuccess: {
                result in
                single(.success(result))
                
            }, onFailure: {
                error in
                single(.failure(error))
            })
        }
    }
    func likeQuestion()->Single<String>{
        return Single<String>.create{single in
            self.usecase.likeQuestion(id:self.questionID).subscribe(onSuccess: {
                result in
                single(.success(result))
                
            }, onFailure: {
                error in
                single(.failure(error))
            })
        }
    }
   
}
