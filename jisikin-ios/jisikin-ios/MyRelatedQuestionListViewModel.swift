//
//  MyRelatedQuestionViewModel.swift
//  jisikin-ios
//
//  Created by 김령교 on 2023/01/20.
//

import Foundation
import RxSwift
import RxCocoa
struct MyRelatedQuestionListModel{
    var title:String
    var content:String?
    var answerCount:Int?
    var createdAt:String?
    var id:Int
    static func fromQuestionAPI(questionAPI:MyRelatedQuestionResponse)->MyRelatedQuestionListModel{
        return MyRelatedQuestionListModel(title:questionAPI.title, content: questionAPI.content, answerCount:questionAPI.answerCount, createdAt: convertTimeFormat(time: questionAPI.createdAt),id:questionAPI.id)
    }
    static func convertTimeFormat(time:String)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
        let date = dateFormatter.date(from: time)!
        let relativeFormatter = RelativeDateTimeFormatter()
        relativeFormatter.locale = Locale(identifier: "ko-KR")
        return relativeFormatter.localizedString(for: date, relativeTo: Date(timeIntervalSinceNow: -60*60*9))//timezone issue
        
    }
}
class MyRelatedQuestionListViewModel{
    var bag = DisposeBag()
    var usecase:MyRelatedQuestionUsecase
    var questions = BehaviorRelay<[MyRelatedQuestionListModel]>(value:[])
    init(usecase:MyRelatedQuestionUsecase){
        self.usecase = usecase
        usecase.myRelatedQuestions.asObservable().subscribe(onNext: {[weak self]
            data in
            if self == nil{return}
            self!.questions.accept(data.map{ questionAPI in
                var question = MyRelatedQuestionListModel.fromQuestionAPI(questionAPI: questionAPI)
                return question
                
            })
        }).disposed(by: bag)
        usecase.answersByQuestionID.asObservable().subscribe(onNext:{[weak self]
            data in
            var value = self!.questions.value
            self!.questions.accept(value)
        })
        }
    
    func getMyQuestions(){
        usecase.getMyQuestions()
    }
    func getMoreMyQuestions(){
        usecase.getMoreMyQuestions()
    }
    
    func getMyAnsweredQuestions(){
        usecase.getMyAnsweredQuestions()
    }
    func getMoreMyAnsweredQuestions(){
        usecase.getMoreMyAnsweredQuestions()
    }
    
    func getMyHeartedQuestions(){
        usecase.getMyHeartedQuestions()
    }
    func getMoreMyHeartedQuestions(){
        usecase.getMoreMyHeartedQuestions()
    }
    
}
