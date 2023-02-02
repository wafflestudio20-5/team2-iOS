//
//  QuestoinTableViewCellForHomeVC.swift
//  jisikin-ios
//
//  Created by Chaehyun Park on 2023/02/02.
//

import UIKit

class QuestionTableViewCellForHomeVC:UITableViewCell{
    
    static let ID = "QuestionTableViewCell"
    
    var questionTitleView:UILabel!
    var questionContentView:UILabel!
    var postedTimeView:UILabel!
    //var answerNumberView:UILabel!
    //var likeNumberView:UILabel!
    //var lineBetweenTimeAndAnswerNumber:UIView!
    //var lineBetweenAnswerNumberAndLikeNumber:UIView!
    var lineAtBottom:UIView!
    //var lineAtBottom2:UIView!
    var lineAtTop:UIView!
    //var imagePreview:UIImageView!
    var imageWidthActiveConstraint:NSLayoutConstraint!
    var imageWidthInActiveConstraint:NSLayoutConstraint!
    var titleViewTrailingImageConstant:NSLayoutConstraint!
    var titleViewTrailingNoImageConstant:NSLayoutConstraint!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setLayout()
        setConstraints()
        
        //setNeedsLayout()
        //contentView.layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setLayout(){
        
        
        questionTitleView = UILabel()
        questionTitleView.numberOfLines = 1
        questionTitleView.textColor = .black
        questionTitleView.font = questionTitleView.font.withSize(18)
        questionTitleView.lineBreakMode = .byTruncatingTail
        questionTitleView.setContentHuggingPriority(.required, for: .vertical)
        
        questionContentView = UILabel()
        questionContentView.numberOfLines = 2
        questionContentView.font = questionContentView.font.withSize(16)
        questionContentView.textColor = .init(red: 141/255, green: 141/255, blue: 141/255, alpha: 1)
        questionContentView.setContentHuggingPriority(.required, for: .vertical)
        postedTimeView = UILabel()
        postedTimeView.textColor = .gray
        postedTimeView.textColor = UIColor(red: 147/255, green: 147/255, blue: 147/255, alpha: 1)
        postedTimeView.textColor = .init(red: 137/255, green: 136/255, blue: 137/255, alpha: 1)
        postedTimeView.setContentHuggingPriority(.required, for: .vertical)
        postedTimeView.font = postedTimeView.font.withSize(12)
        /*lineBetweenTimeAndAnswerNumber = UIView()
        lineBetweenTimeAndAnswerNumber.backgroundColor = UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1)
        */
        /*
        answerNumberView = UILabel()
        answerNumberView.textAlignment = .center
        answerNumberView.textColor = .init(red: 111/255, green: 111/255, blue: 111/255, alpha: 1)
        answerNumberView.font = answerNumberView.font.withSize(15)
        answerNumberView.backgroundColor = UIColor(red: 251/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1)
        
        likeNumberView = UILabel()
        likeNumberView.textAlignment = .center
        likeNumberView.font = likeNumberView.font.withSize(15)
        likeNumberView.backgroundColor = UIColor(red: 251/255.0, green: 250/255.0, blue: 250/255.0, alpha: 1)
        likeNumberView.textColor = .init(red: 111/255, green: 111/255, blue: 111/255, alpha: 1)
        
        lineBetweenAnswerNumberAndLikeNumber = UIView()
        lineBetweenAnswerNumberAndLikeNumber.backgroundColor = UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1)
        */
        
        lineAtBottom = UIView()
        lineAtBottom.backgroundColor = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1)
        //lineAtBottom2 = UIView()
        //lineAtBottom2.backgroundColor = UIColor(red: 235/255.0, green: 235/255.0, blue: 235/255.0, alpha: 1)*/
        lineAtTop = UIView()
        lineAtTop.backgroundColor = UIColor(red: 241/255.0, green: 241/255.0, blue: 241/255.0, alpha: 1)
        /*imagePreview = UIImageView()
        imagePreview.contentMode = .scaleAspectFill
        imagePreview.layer.masksToBounds = true
        imagePreview.backgroundColor = .systemTeal
        */
        
        questionTitleView.translatesAutoresizingMaskIntoConstraints = false
        questionContentView.translatesAutoresizingMaskIntoConstraints = false
        postedTimeView.translatesAutoresizingMaskIntoConstraints = false
        //lineBetweenTimeAndAnswerNumber.translatesAutoresizingMaskIntoConstraints = false
        //answerNumberView.translatesAutoresizingMaskIntoConstraints = false
        //lineBetweenAnswerNumberAndLikeNumber.translatesAutoresizingMaskIntoConstraints = false
        //likeNumberView.translatesAutoresizingMaskIntoConstraints = false
        lineAtBottom.translatesAutoresizingMaskIntoConstraints = false
        //lineAtBottom2.translatesAutoresizingMaskIntoConstraints = false
        //lineAtTop.translatesAutoresizingMaskIntoConstraints = false
        //imagePreview.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(questionTitleView)
        contentView.addSubview(questionContentView)
        contentView.addSubview(postedTimeView)
        //contentView.addSubview(lineBetweenTimeAndAnswerNumber)
        //contentView.addSubview(answerNumberView)
        //contentView.addSubview(lineBetweenAnswerNumberAndLikeNumber)
        //contentView.addSubview(likeNumberView)
        contentView.addSubview(lineAtBottom)
        //contentView.addSubview(lineAtBottom2)
        //contentView.addSubview(imagePreview)
        contentView.addSubview(lineAtTop)
    }
    func setConstraints(){
        NSLayoutConstraint.activate([
            lineAtTop.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            lineAtTop.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            lineAtTop.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            lineAtTop.heightAnchor.constraint(equalToConstant: 2.0)
        ])
        NSLayoutConstraint.activate([
            questionTitleView.topAnchor.constraint(equalTo: lineAtTop.bottomAnchor,constant:10.0),
            questionTitleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 20.0),
            questionTitleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20.0)
                        
        ])
        NSLayoutConstraint.activate([
            questionContentView.topAnchor.constraint(equalTo: questionTitleView.bottomAnchor,constant: 5.0),
            questionContentView.leadingAnchor.constraint(equalTo: questionTitleView.leadingAnchor),
            questionContentView.trailingAnchor.constraint(equalTo: questionTitleView.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            postedTimeView.topAnchor.constraint(equalTo: questionContentView.bottomAnchor,constant: 5.0),
            postedTimeView.leadingAnchor.constraint(equalTo: questionTitleView.leadingAnchor)
        ])
        /*NSLayoutConstraint.activate([
            lineBetweenTimeAndAnswerNumber.topAnchor.constraint(equalTo: postedTimeView.bottomAnchor,constant: 5.0),
            lineBetweenTimeAndAnswerNumber.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            lineBetweenTimeAndAnswerNumber.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            lineBetweenTimeAndAnswerNumber.heightAnchor.constraint(equalToConstant: 1.0)
        ])*/
       /*NSLayoutConstraint.activate([
            answerNumberView.topAnchor.constraint(equalTo: lineBetweenTimeAndAnswerNumber.bottomAnchor),
            answerNumberView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
        
            answerNumberView.heightAnchor.constraint(equalToConstant: 50.0),
          
        ])
        NSLayoutConstraint.activate([
            lineBetweenAnswerNumberAndLikeNumber.widthAnchor.constraint(equalToConstant: 1.0),
            lineBetweenAnswerNumberAndLikeNumber.topAnchor.constraint(equalTo: answerNumberView.topAnchor),
            lineBetweenAnswerNumberAndLikeNumber.leadingAnchor.constraint(equalTo: answerNumberView.trailingAnchor),
            lineBetweenAnswerNumberAndLikeNumber.bottomAnchor.constraint(equalTo: answerNumberView.bottomAnchor)
        ])
        NSLayoutConstraint.activate([
            likeNumberView.topAnchor.constraint(equalTo: answerNumberView.topAnchor),
            likeNumberView.leadingAnchor.constraint(equalTo: lineBetweenAnswerNumberAndLikeNumber.trailingAnchor),
            likeNumberView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            likeNumberView.bottomAnchor.constraint(equalTo: answerNumberView.bottomAnchor),
            likeNumberView.widthAnchor.constraint(equalTo: answerNumberView.widthAnchor)
        ])*/
        
        NSLayoutConstraint.activate([
            lineAtBottom.topAnchor.constraint(equalTo: postedTimeView.bottomAnchor,constant: 5.0),
            lineAtBottom.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            lineAtBottom.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            lineAtBottom.heightAnchor.constraint(equalToConstant: 1.0),
            lineAtBottom.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)

        ])
        /*NSLayoutConstraint.activate([
            lineAtBottom2.topAnchor.constraint(equalTo: lineAtBottom.bottomAnchor),
            lineAtBottom2.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            lineAtBottom2.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            lineAtBottom2.bottomAnchor.constraint(equalTo:contentView.safeAreaLayoutGuide.bottomAnchor),
            lineAtBottom2.heightAnchor.constraint(equalToConstant: 6.0)
        ])
        NSLayoutConstraint.activate([
            imagePreview.topAnchor.constraint(equalTo: questionTitleView.topAnchor),
            imagePreview.bottomAnchor.constraint(equalTo: postedTimeView.centerYAnchor),
            imagePreview.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor,constant: -20.0),
           
            
        ])*/
        /*
        imageWidthActiveConstraint = imagePreview.widthAnchor.constraint(equalTo: imagePreview.heightAnchor)
        imageWidthActiveConstraint.isActive = true
        imageWidthInActiveConstraint = imagePreview.widthAnchor.constraint(equalToConstant: 0)
        imageWidthInActiveConstraint.isActive = false
        titleViewTrailingImageConstant = questionTitleView.trailingAnchor.constraint(equalTo: imagePreview.leadingAnchor,constant: -20.0)
        titleViewTrailingImageConstant.isActive = true*/
        //titleViewTrailingNoImageConstant = questionTitleView.trailingAnchor.constraint(equalTo: imagePreview.leadingAnchor)
    }
   
    func configure(question:MyRelatedQuestionListModel){
        questionTitleView.text = question.title
        questionContentView.text = question.content
        postedTimeView.text = question.createdAt
        
        postedTimeView.text = "\(question.createdAt!)\(question.answerCount != nil ? " | 답변 \(question.answerCount!)" : "")"
    }
    
    /*func configurePhoto(url:String?){
        if let url{
            imageWidthInActiveConstraint.isActive = false
            imageWidthActiveConstraint.isActive = true
            titleViewTrailingImageConstant.isActive = true
            titleViewTrailingNoImageConstant.isActive = false
            questionContentView.text = questionContentView.text! + "\n" //to force contentview with 2 lines, for constant image size
            imagePreview.kf.setImage(with: URL(string: url)!)
            }
        else{
            imageWidthActiveConstraint.isActive = false
            imageWidthInActiveConstraint.isActive = true
            titleViewTrailingImageConstant.isActive = false
            titleViewTrailingNoImageConstant.isActive = true
        }
        setNeedsLayout()
        contentView.layoutIfNeeded()
    }*/
      
    
    
}

