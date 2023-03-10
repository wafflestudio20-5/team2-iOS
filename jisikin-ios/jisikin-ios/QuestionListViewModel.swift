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
    var createdAt:String
    var questionTag:[String]
    var photo:String?
    static func fromQuestionAPI(questionAPI:QuestionSearchAPI)->QuestionListModel{
        return QuestionListModel(questionId: questionAPI.questionId, title: questionAPI.title, content: questionAPI.content, answerContent: questionAPI.answerContent, answerCount: questionAPI.answerCount, questionLikeCount: questionAPI.questionLikeCount,createdAt:convertTimeFormat(time: questionAPI.questionCreatedAt), questionTag: questionAPI.questionTag,photo: questionAPI.photo)
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
    func getQuestionsByLikes(){
        usecase.getQuestionsByLikes()
    }
    func getMoreQuestionsByLikes(){
        usecase.getMoreQuestionsByLikes()
    }

    func getQuestionsByDate(){
        usecase.getQuestionsByDate()
    }
    func getMoreQuestionsByDate(){
        usecase.getMoreQuestionsByDate()
    }
    
    func searchQuestions(keyword:String){
        usecase.searchQuestions(keyword: keyword)
    }
    func searchMoreQuestions(keyword:String){
        usecase.searchMoreQuestions(keyword: keyword)
    }
    
    func postNewQuestion(titleText: String, contentText: String, tag: [String], photos: [UIImage]) {
        //let urlPhotos: [String] = UIImageToURL(photos: photos)
        usecase.postNewQuestion(titleText: titleText, contentText: contentText, tag: tag, photos: photos)
    }
    
    func editQuestion(questionID: Int, titleText: String, contentText: String, tag: [String], photos: [UIImage], completionhandler: @escaping ((String) -> Void)) {
        usecase.editQuestion(questionID: questionID, titleText: titleText, contentText: contentText, tag: tag, photos: photos){
            result in
            completionhandler(result)
        }
    }
    
    func postNewAnswer(id: Int, contentText: String, photos: [UIImage], completionhandler: @escaping ((String) -> Void)) {
        usecase.postNewAnswer(id: id, contentText: contentText, photos: photos){
            result in
          completionhandler(result)
        }
    }
    
    func editAnswer(id: Int, contentText: String, photos: [UIImage], completionhandler: @escaping ((String) -> Void)) {
        usecase.editAnswer(id: id, contentText: contentText, photos: photos){
            result in
            completionhandler(result)
        }
    }
    
    func getRandomQuestionID(completionHandler:@escaping (Int)->Void){
        usecase.getRandomQuestionAndAnswers(completionHandler: { _ in
            completionHandler(self.usecase.qid)
        })
    }
    
    func getAdminQuestionID(completionHandler:@escaping (Int)->Void){
        usecase.getAdminQuestionAndAnswers(completionHandler: { _ in
            completionHandler(self.usecase.qid)
        })
    }
}
 

