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
    var questionId:Int
    var title:String
    var content:String
    var answerContent:String?
    var answerCount:Int
    var questionLikeCount:Int
    
    static func fromQuestionAPI(questionAPI:QuestionSearchAPI)->QuestionListModel{
        return QuestionListModel(questionId: questionAPI.questionId, title: questionAPI.title, content: questionAPI.content, answerContent: questionAPI.answerContent, answerCount: questionAPI.answerCount, questionLikeCount: questionAPI.questionLikeCount)
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
        usecase.questionSearch.asObservable().subscribe(onNext:{
            questions in
            self.questions.accept(questions.map{
                QuestionListModel.fromQuestionAPI(questionAPI: $0)
            })
        })
        }
    func getQuestions(){
        usecase.getQuestionsByLikes()
    }
    
    func postNewQuestion(titleText: String, contentText: String) {
        usecase.postNewQuestion(titleText: titleText, contentText: contentText)
    }
    
    func postNewAnswer(id: Int, contentText: String,handler:@escaping(()->())) {
        usecase.postNewAnswer(id: id, contentText: contentText){
            handler()
        }
    }
}
 

