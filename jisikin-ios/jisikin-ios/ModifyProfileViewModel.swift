////
////  ModifyProfileViewModel.swift
////  jisikin-ios
////
////  Created by 김령교 on 2023/01/17.
////
//
//import Foundation
//import UIKit
//import RxSwift
//import RxCocoa
//struct ProfileDetailModel{
//    var content:String
//    var photos:[UIImage] = []
//    var createdAt:String
//    var selected:Bool
//    var username:String
//    var profileImage:UIImage?
//    var userRecentAnswerDate:String
//    var id:Int
//
//    static func fromAnswerAPI(answerAPI:AnswerAPI)->AnswerDetailModel{
//        return AnswerDetailModel(content: answerAPI.content, createdAt: answerAPI.createdAt, selected: answerAPI.selected, username: answerAPI.username, userRecentAnswerDate:convertTimeFormat(time: answerAPI.userRecentAnswerDate),id:answerAPI.id)
//    }
//    static func convertTimeFormat(time:String)->String{
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
//        let date = dateFormatter.date(from: time)!
//        let relativeFormatter = RelativeDateTimeFormatter()
//        dateFormatter.timeZone = TimeZone(identifier: "UTC+9")
//        dateFormatter.dateFormat = "yyyy.MM.dd"
//        return dateFormatter.string(from: date)
//    }
//}
//struct ProfileModel{
//    var title:String
//    var content:String
//    var photos:[UIImage] = []
//    var createdAt:String
//    var username:String
//    var close:Bool
//    static func fromQuestionAPI(questionAPI:QuestionAPI?)->QuestionDetailModel?{
//
//        if let questionAPI = questionAPI{
//            return QuestionDetailModel(title: questionAPI.title, content: questionAPI.content, createdAt:convertTimeFormat(time: questionAPI.createdAt),username:questionAPI.username,close:questionAPI.close)
//        }
//        else{
//            return nil
//        }
//    }
//    static func convertTimeFormat(time:String)->String{
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
//        let date = dateFormatter.date(from: time)!
//        let relativeFormatter = RelativeDateTimeFormatter()
//        dateFormatter.timeZone = TimeZone(identifier: "UTC+9")
//        dateFormatter.dateFormat = "yyyy.MM.dd"
//        return dateFormatter.string(from: date)
//    }
//}
//class ProfileViewModel{
//    var bag = DisposeBag()
//    var usecase:ProfileUsecase
//    var questionID:Int
//    var question = BehaviorRelay<QuestionDetailModel?>(value:nil)
//    var answers = BehaviorRelay<[AnswerDetailModel]>(value:[])
//    init(usecase: QuestionAnswerUsecase, questionID: Int) {
//        self.usecase = usecase
//        self.questionID = questionID
//        usecase.questions.asObservable().subscribe(onNext: {[weak self]
//            data in
//            self!.question.accept(QuestionDetailModel.fromQuestionAPI(questionAPI:data.first(where: {$0.id == self!.questionID})))
//
//        }).disposed(by: bag)
//        usecase.answersByQuestionID.asObservable().subscribe(onNext:{[weak self]
//            data in
//            if data[self!.questionID] == nil{
//                self!.answers.accept([])
//                return
//            }
//            self!.answers.accept( ((data[self!.questionID])?.map({
//                AnswerDetailModel.fromAnswerAPI(answerAPI: $0)
//            }))!)
//        }).disposed(by: bag)
//    }
//    func refresh(){
//        usecase.getQuestionAndAnswersByID(id: questionID)
//    }
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
//}
