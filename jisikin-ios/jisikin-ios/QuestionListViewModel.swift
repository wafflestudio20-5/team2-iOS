//
//  QuestionListViewModel.swift
//  jisikin-ios
//
//  Created by 박정헌 on 2023/01/07.
//

import Foundation
struct QuestionListModel{
    var title:String
    var content:String
    var answerNumber:Int?
    var createdAt:String
    static func fromQuestionAPI(questionAPI:QuestionAPI)->QuestionListModel{
        return QuestionListModel(title:questionAPI.title,content:questionAPI.content,answerNumber:nil, createdAt: convertTimeFormat(time: questionAPI.createdAt))
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
    var onQuestionListChanged:(([QuestionListModel])->())?
    var questionAPIList:[QuestionAPI] = []
    
    var questionListModelList:[QuestionListModel] = []{
        didSet(oldVal){
            onQuestionListChanged?(questionListModelList)
        }
    }
    
    let questionRepository = QuestionRepository()
    let answerRepository = AnswerRepository()
    
    func getRecentQuestions(){
        questionRepository.getRecentQuestions{ [weak self]questions in
            if self == nil{
                return
            }
            if self!.questionRepository.isError{
                return
            }
            self!.questionAPIList = questions
            self!.questionListModelList = self!.questionAPIList.map{
                QuestionListModel.fromQuestionAPI(questionAPI: $0)
            }
            for (i,question) in self!.questionAPIList.enumerated(){
                self!.answerRepository.getAnswersByQuestionID(id: question.id){
                    answers in
                    if self!.answerRepository.isError{
                        return
                    }
                    self!.questionListModelList[i].answerNumber = answers.count
                    
                }
            }
        }
    }
}
