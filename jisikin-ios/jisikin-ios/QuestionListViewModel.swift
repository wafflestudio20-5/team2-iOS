//
//  QuestionListViewModel.swift
//  jisikin-ios
//
//  Created by 박정헌 on 2023/01/07.
//

import Foundation
import RxSwift
import RxCocoa
struct QuestionListModel{
    var title:String
    var content:String
    var answerNumber:Int?
    var createdAt:String?
    var id:Int
    static func fromQuestionAPI(questionAPI:QuestionAPI)->QuestionListModel{
        return QuestionListModel(title:questionAPI.title,content:questionAPI.content,answerNumber:nil, createdAt: convertTimeFormat(time: questionAPI.createdAt!),id:questionAPI.id)
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
class QuestionListViewModel{
    var bag = DisposeBag()
    var usecase:QuestionAnswerUsecase
    var questions = BehaviorRelay<[QuestionListModel]>(value:[])
    init(usecase:QuestionAnswerUsecase){
        self.usecase = usecase
        usecase.questions.asObservable().subscribe(onNext: {[weak self]
            data in
            if self == nil{return}
            self!.questions.accept(data.map{ questionAPI in
                var question = QuestionListModel.fromQuestionAPI(questionAPI: questionAPI)
                question.answerNumber = usecase.answersByQuestionID.value[question.id]?.count
                return question
                
            })
        }).disposed(by: bag)
        usecase.answersByQuestionID.asObservable().subscribe(onNext:{[weak self]
            data in
            if self == nil{return}
            var value = self!.questions.value
            if value.count == 0{
                return
            }
            for i in 0...value.count-1{
                value[i].answerNumber = data[value[i].id]?.count
            }
            self!.questions.accept(value)
            
        })
        }
    func getQuestions(){
        usecase.getQuestionsAndAnswers()
    }
    
    func getMyQuestions(){
        usecase.getMyQuestions()
    }
    
    func getMyAnsweredQuestions(){
        usecase.getMyAnsweredQuestions()
    }
    
    func getMyHeartedQuestions(){
        usecase.getMyHeartedQuestions()
    }
    
    func postNewQuestion(titleText: String, contentText: String) {
        usecase.postNewQuestion(titleText: titleText, contentText: contentText)
    }
    
    func postNewAnswer(id: Int, contentText: String) {
        usecase.postNewAnswer(id: id, contentText: contentText)
    }
}
 

