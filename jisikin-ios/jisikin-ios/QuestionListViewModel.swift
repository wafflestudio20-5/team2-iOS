//
//  QuestionListViewModel.swift
//  jisikin-ios
//
//  Created by 박정헌 on 2023/01/07.
//

import Foundation
struct QuestionListVM{
    var title:String
    var content:String
    var answerNumber:Int?
    var createdAt:String
    static func fromQuestionAPI(questionAPI:QuestionAPI)->QuestionListVM{
        return QuestionListVM(title:questionAPI.title,content:questionAPI.content,answerNumber:nil, createdAt: convertTimeFormat(time: questionAPI.createdAt))
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
    var onQuestionListChanged:(([QuestionListVM])->())?
    var questionAPIList:[QuestionAPI] = []
    
    var questionListVMList:[QuestionListVM] = []{
        didSet(oldVal){
            onQuestionListChanged?(questionListVMList)
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
            self!.questionListVMList = self!.questionAPIList.map{
                QuestionListVM.fromQuestionAPI(questionAPI: $0)
            }
            for (i,question) in self!.questionAPIList.enumerated(){
                self!.answerRepository.getAnswersByQuestionID(id: question.id){
                    answers in
                    if self!.answerRepository.isError{
                        return
                    }
                    self!.questionListVMList[i].answerNumber = answers.count
                    
                }
            }
        }
    }
}
