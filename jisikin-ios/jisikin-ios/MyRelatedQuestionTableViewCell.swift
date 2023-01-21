//
//  MyRelatedQuestionTableViewCell.swift
//  jisikin-ios
//
//  Created by 김령교 on 2023/01/20.
//

import UIKit

class MyRelatedQuestionTableViewCell:UITableViewCell{
    
    static let ID = "QuestionTableViewCell"
    
    var questionTitleView:UILabel!
    var postedTimeAndAnswerNumberView:UILabel!
    var lineAtBottom:UIView!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setLayout(){
        
        
        questionTitleView = UILabel()
        questionTitleView.numberOfLines = 1
        questionTitleView.textColor = .black
        questionTitleView.font = questionTitleView.font.withSize(20)
        questionTitleView.lineBreakMode = .byTruncatingTail
        
        postedTimeAndAnswerNumberView = UILabel()
        postedTimeAndAnswerNumberView.textColor = .gray
        postedTimeAndAnswerNumberView.textColor = UIColor(red: 147/255, green: 147/255, blue: 147/255, alpha: 1)
        
        lineAtBottom = UIView()
        lineAtBottom.backgroundColor = UIColor(red: 235/255.0, green: 235/255.0, blue: 235/255.0, alpha: 1)
        
        questionTitleView.translatesAutoresizingMaskIntoConstraints = false
        postedTimeAndAnswerNumberView.translatesAutoresizingMaskIntoConstraints = false
        lineAtBottom.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(questionTitleView)
        contentView.addSubview(postedTimeAndAnswerNumberView)
        contentView.addSubview(lineAtBottom)
    }
    func setConstraints(){
        NSLayoutConstraint.activate([
            questionTitleView.topAnchor.constraint(equalTo: contentView.topAnchor,constant:10.0),
            questionTitleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20.0),
            questionTitleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20.0)
                        
        ])
        NSLayoutConstraint.activate([
            postedTimeAndAnswerNumberView.topAnchor.constraint(equalTo: questionTitleView.bottomAnchor,constant: 5.0),
            postedTimeAndAnswerNumberView.leadingAnchor.constraint(equalTo: questionTitleView.leadingAnchor)
        ])
        NSLayoutConstraint.activate([
            lineAtBottom.topAnchor.constraint(equalTo: postedTimeAndAnswerNumberView.bottomAnchor, constant:10.0),
            lineAtBottom.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            lineAtBottom.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            lineAtBottom.heightAnchor.constraint(equalToConstant: 1.0),
            lineAtBottom.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
   
    func configure(question:MyRelatedQuestionListModel){
        questionTitleView.text = question.title
        postedTimeAndAnswerNumberView.text = question.createdAt! + " | " + (question.answerCount != nil ? "답변 \(question.answerCount!)" : "공감")
    }
    
}
