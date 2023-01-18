//
//  QuestionDetailFromWritingAnswerViewController.swift
//  jisikin-ios
//
//  Created by Chaehyun Park on 2023/01/17.
//

import Foundation
import UIKit

class SimpleQuestionView:UIView{
    var questionTitleView:UILabel!
    var questionUserInfo:UILabel!
    var questionContentView:UILabel!
    var questionTimeView:UILabel!
    var imageStackView:UIStackView!
    var questionImages:[UIImage] = []
    override init(frame:CGRect){
        super.init(frame:frame)
        setLayout()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLayout(){
        backgroundColor = .white
        
        questionTitleView = UILabel()
        questionTitleView.font = questionTitleView.font.withSize(30)
        questionTitleView.textColor = .black
        questionTitleView.text = "게임 이름 기억 안남"
     
        questionUserInfo = UILabel()
        questionUserInfo.textColor = .gray
        questionUserInfo.text = "impri 질문수 10"
        
        questionContentView = UILabel()
        questionContentView.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean porta lacus vel justo interdum, ac mollis est blandit. Praesent et leo tempus, imperdiet mi sed, molestie tellus. Etiam faucibus velit at massa vestibulum, nec vestibulum nunc pretium. Duis ut diam at lectus elementum egestas. Integer gravida rutrum elit. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc aliquet sapien vel tortor dignissim, sit amet tempor felis eleifend. Proin in arcu condimentum, cursus ipsum sit amet, tristique neque. Etiam nec purus dignissim, sodales felis vitae, pharetra elit. Donec malesuada sed lacus nec consequat. Phasellus nec tortor gravida, porttitor mauris id, placerat magna. Proin sodales interdum turpis, ac scelerisque ipsum elementum tempus. Quisque eu felis elit. Nam et scelerisque purus. Suspendisse maximus nunc dolor. Praesent diam tortor, venenatis non libero eget, egestas sodales odio."
        questionContentView.numberOfLines = 0
        questionContentView.lineBreakMode = .byWordWrapping
        questionContentView.font = questionTitleView.font.withSize(20)
        
        questionTimeView = UILabel()
        questionTimeView.text = "2022.12.16"
        questionTimeView.textColor = .black
        
        questionImages = [UIColor.yellow.image(CGSize(width: 100, height: 100)),UIColor.orange.image(CGSize(width: 100, height: 100)),UIColor.blue.image(CGSize(width: 1200, height: 800))]
        
        imageStackView = UIStackView()
        imageStackView.axis = .vertical
        imageStackView.distribution = .equalSpacing
        imageStackView.alignment = .leading
        imageStackView.spacing = 20
        for image in questionImages{
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageStackView.addArrangedSubview(imageView)
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(lessThanOrEqualTo:imageStackView.widthAnchor),
                imageView.widthAnchor.constraint(equalTo:imageView.heightAnchor,multiplier: image.size.width/image.size.height)
            ])
        }
        
        
        questionTitleView.translatesAutoresizingMaskIntoConstraints = false
        questionUserInfo.translatesAutoresizingMaskIntoConstraints = false
        questionContentView.translatesAutoresizingMaskIntoConstraints = false
        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        questionTimeView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(questionTitleView)
        addSubview(questionUserInfo)
        addSubview(questionContentView)
        addSubview(imageStackView)
        addSubview(questionTimeView)
        
    }
    
    func setConstraint(){
        NSLayoutConstraint.activate([
            questionTitleView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,constant: 20),
            questionTitleView.leadingAnchor.constraint(equalTo:  self.leadingAnchor,constant: 20.0),
            questionTitleView.trailingAnchor.constraint(equalTo:  self.trailingAnchor,constant: -20.0)
        ])
        NSLayoutConstraint.activate([
            questionUserInfo.leadingAnchor.constraint(equalTo: questionTitleView.leadingAnchor),
            questionUserInfo.topAnchor.constraint(equalTo: questionTitleView.bottomAnchor,constant: 20.0)
        ])
       NSLayoutConstraint.activate([
            questionContentView.leadingAnchor.constraint(equalTo: questionTitleView.leadingAnchor),
            questionContentView.trailingAnchor.constraint(equalTo: questionTitleView.trailingAnchor),
            questionContentView.topAnchor.constraint(equalTo: questionUserInfo.bottomAnchor,constant: 5.0)
        ])
        NSLayoutConstraint.activate([
            imageStackView.leadingAnchor.constraint(equalTo: questionTitleView.leadingAnchor),
            imageStackView.trailingAnchor.constraint(equalTo: questionTitleView.trailingAnchor),
            imageStackView.topAnchor.constraint(equalTo: questionContentView.bottomAnchor,constant: 5.0)
        ])
        NSLayoutConstraint.activate([
            questionTimeView.leadingAnchor.constraint(equalTo: questionTitleView.leadingAnchor),
            questionTimeView.topAnchor.constraint(equalTo: imageStackView.bottomAnchor,constant: 5.0),
        ])
    }
    func configure(question:QuestionModelForAnswerVC){
        questionTitleView.text = question.title
        questionTimeView.text = question.createdAt
        questionContentView.text = question.content
        questionUserInfo.text = question.username
    }
}

class QuestionDetailFromWritingAnswerViewController:UIViewController{
    var questionView = SimpleQuestionView()
    var headerView : UITableViewHeaderFooterView!
    var question:QuestionModelForAnswerVC
    init(question:QuestionModelForAnswerVC){
        self.question = question
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setLayout()
        setConstraint()
    }

    func setLayout(){
        questionView.configure(question:question)
        questionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(questionView)
    }
    func setConstraint(){
        NSLayoutConstraint.activate([
            questionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            questionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            questionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}
