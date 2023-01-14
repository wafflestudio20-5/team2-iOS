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
    var photos:[UIImage] = []
    var createdAt:String
    var selected:Bool
    var username:String
    var profileImage:UIImage?
    var userRecentAnswerDate:String
    
    static func fromAnswerAPI(answerAPI:AnswerAPI)->AnswerDetailModel{
        return AnswerDetailModel(content: answerAPI.content, createdAt: answerAPI.createdAt, selected: answerAPI.selected, username: answerAPI.username, userRecentAnswerDate:convertTimeFormat(time: answerAPI.userRecentAnswerDate))
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
    var photos:[UIImage] = []
    var createdAt:String
    var username:String
    static func fromQuestionAPI(questionAPI:QuestionAPI?)->QuestionDetailModel?{
       
        if let questionAPI = questionAPI{
            return QuestionDetailModel(title: questionAPI.title, content: questionAPI.content, createdAt:convertTimeFormat(time: questionAPI.createdAt),username:questionAPI.username)
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
        usecase.questions.asObservable().subscribe(onNext: {[weak self]
            data in
            self!.question.accept(QuestionDetailModel.fromQuestionAPI(questionAPI:data.first(where: {$0.id == self!.questionID})))
            
        }).disposed(by: bag)
        usecase.answersByQuestionID.asObservable().subscribe(onNext:{[weak self]
            data in
            if data[self!.questionID] == nil{
                self!.answers.accept([])
                return
            }
            self!.answers.accept( ((data[self!.questionID])?.map({
                AnswerDetailModel.fromAnswerAPI(answerAPI: $0)
            }))!)
        }).disposed(by: bag)
    }
}
