////
////  MyQAViewModel.swift
////  jisikin-ios
////
////  Created by 김령교 on 2023/01/17.
////
//
//import Foundation
//import RxSwift
//import RxCocoa
//struct MyQAListModel{
//    var title:String
//    var content:String
//    var answerNumber:Int?
//    var createdAt:String
//    var id:Int
//    static func fromQuestionAPI(questionAPI:QuestionAPI)->MyQAListModel{
//        return MyQAListModel(title:questionAPI.title,content:questionAPI.content,answerNumber:nil, createdAt: convertTimeFormat(time: questionAPI.createdAt),id:questionAPI.id)
//    }
//    static func convertTimeFormat(time:String)->String{
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSS"
//        let date = dateFormatter.date(from: time)!
//        let relativeFormatter = RelativeDateTimeFormatter()
//        relativeFormatter.locale = Locale(identifier: "ko-KR")
//        return relativeFormatter.localizedString(for: date, relativeTo: Date(timeIntervalSinceNow: -60*60*9))//timezone issue
//        
//    }
//}
//class MyQAListViewModel{
//    var bag = DisposeBag()
//    var usecase:MyQAUsecase
//    var questions = BehaviorRelay<[MyQAListModel]>(value:[])
//    init(usecase:MyQAUsecase){
//        self.usecase = usecase
//        usecase.questions.asObservable().subscribe(onNext: {[weak self]
//            data in
//            if self == nil{return}
//            self!.questions.accept(data.map{ questionAPI in
//                var question = MyQAListModel.fromQuestionAPI(questionAPI: questionAPI)
//                question.answerNumber = usecase.answersByQuestionID.value[question.id]?.count
//                return question
//                
//            })
//        }).disposed(by: bag)
//        usecase.answersByQuestionID.asObservable().subscribe(onNext:{[weak self]
//            data in
//            if self == nil{return}
//            var value = self!.questions.value
//            if value.count == 0{
//                return
//            }
//            for i in 0...value.count-1{
//                value[i].answerNumber = data[value[i].id]?.count
//            }
//            self!.questions.accept(value)
//            
//        })
//        }
//    func getQuestions(){
//        usecase.getQuestionsAndAnswers()
//    }
//    
//    func postNewQuestion(titleText: String, contentText: String) {
//        usecase.postNewQuestion(titleText: titleText, contentText: contentText)
//    }
//    
//    func postNewAnswer(id: Int, contentText: String) {
//        usecase.postNewAnswer(id: id, contentText: contentText)
//    }
//}
// 
//
