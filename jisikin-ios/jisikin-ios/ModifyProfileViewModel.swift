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
////    eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhY2Nlc3MiLCJ1aWQiOiJibHVlS29uZyIsImlzcyI6InRlYW0yLndhZmZsZXN0dWRpby5jb20iLCJpYXQiOjE2NzQwMjUzNjUsImV4cCI6MTY3NDAyNTY2NX0.FJGwCKownCP0x1o4XtaZ8bUYtQF0sHBiOq-DR_0xGNA
//}
//class ProfileViewModel{
//    var bag = DisposeBag()
//    var usecase:ProfileUsecase
//    var data:Profile
//    init(usecase: ProfileUsecase, questionID: Int) {
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
