//
//  QuestionDetailViewController.swift
//  jisikin-ios
//
//  Created by 박정헌 on 2022/12/29.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Kingfisher
class QuestionView:UIView{
    var tags:[String] = []
    
    var questionTitleView:UILabel!
    var questionUserInfo:UILabel!
    var questionContentView:UILabel!
    var questionTimeView:UILabel!
    var questionEditButton:UIButton!
    var questionDeleteButton:UIButton!
    var likeNumberView:UILabel!
    var likeButton:UIButton!
    var answerButton:UIButton!
    var imageStackView:UIStackView!
    var tagView:SelfSizingCollectionView!
    var questionImages:[UIImage] = []
    var onAnswerButtonClicked:(()->())?
    var onImageLoaded:(()->())?
    var onDeleteButtonClicked:(()->())?
    var onLikeButtonClicked:(()->())?
    override init(frame:CGRect){
        super.init(frame:frame)
        setLayout()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setLayout(){
        
        
        questionTitleView = UILabel()
        questionTitleView.font = questionTitleView.font.withSize(30)
        questionTitleView.textColor = .black
        questionTitleView.numberOfLines = 0
       
     
        questionUserInfo = UILabel()
        questionUserInfo.textColor = .gray
        
        
        questionContentView = UILabel()
        questionContentView.numberOfLines = 0
        questionContentView.lineBreakMode = .byWordWrapping
        questionContentView.font = questionTitleView.font.withSize(20)
        
        likeButton = UIButton()
        likeButton.setTitleColor(.black, for: .normal)
        likeButton.setImage(systemName: "heart", color: UIColor.red)
        
        likeButton.addTarget(self, action: #selector(likeButtonClicked), for: .touchDown)
        
        likeNumberView = UILabel()
        likeNumberView.font = likeNumberView.font.withSize(30)
        questionTimeView = UILabel()
        questionTimeView.textColor = .lightGray
        questionEditButton = UIButton()
        questionEditButton.setTitle("수정", for: .normal)
        questionEditButton.setTitleColor(.gray, for: .normal)
        
        questionDeleteButton = UIButton()
        questionDeleteButton.setTitle("삭제", for: .normal)
        questionDeleteButton.setTitleColor(.gray, for: .normal)
        questionDeleteButton.addTarget(self, action: #selector(deleteButtonClicked), for: .touchDown)
        
        answerButton = UIButton()
        answerButton.setImage(UIImage(named: "AnswerButton"), for: .normal)
        answerButton.addTarget(self, action: #selector(answerButtonClicked(_:)), for: .touchUpInside)
        answerButton.imageView?.contentMode = .scaleAspectFit
        answerButton.backgroundColor = BLUE_COLOR
        
        let layout = UICollectionViewFlowLayout()
        tagView = SelfSizingCollectionView(frame: .zero, collectionViewLayout: layout)
        tagView.dataSource = self
        tagView.delegate = self
        tagView.register(DetailTagViewCell.self, forCellWithReuseIdentifier: DetailTagViewCell.identifier)
        imageStackView = UIStackView()
        imageStackView.axis = .vertical
        imageStackView.distribution = .equalSpacing
        imageStackView.alignment = .leading
        imageStackView.spacing = 20
     
        
        questionTitleView.translatesAutoresizingMaskIntoConstraints = false
        questionUserInfo.translatesAutoresizingMaskIntoConstraints = false
        questionContentView.translatesAutoresizingMaskIntoConstraints = false
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        questionTimeView.translatesAutoresizingMaskIntoConstraints = false
        questionEditButton.translatesAutoresizingMaskIntoConstraints = false
        questionDeleteButton.translatesAutoresizingMaskIntoConstraints = false
        answerButton.translatesAutoresizingMaskIntoConstraints = false
        likeNumberView.translatesAutoresizingMaskIntoConstraints = false
        tagView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(questionTitleView)
        addSubview(questionUserInfo)
        addSubview(questionContentView)
        addSubview(likeButton)
        addSubview(likeNumberView)
        addSubview(imageStackView)
        addSubview(questionTimeView)
        addSubview(questionEditButton)
        addSubview(questionDeleteButton)
        addSubview(answerButton)
        addSubview(tagView)
        
    }
    
    func setConstraint(){
        NSLayoutConstraint.activate([
            questionTitleView.topAnchor.constraint(equalTo: self.topAnchor,constant: 0),
            questionTitleView.leadingAnchor.constraint(equalTo:  self.leadingAnchor,constant: 20.0),
            questionTitleView.trailingAnchor.constraint(equalTo:  self.trailingAnchor,constant: -20.0)
        ])
        NSLayoutConstraint.activate([
            questionUserInfo.leadingAnchor.constraint(equalTo: questionTitleView.leadingAnchor),
            questionUserInfo.topAnchor.constraint(equalTo: questionTitleView.bottomAnchor,constant: 15.0)
        ])
        NSLayoutConstraint.activate([
            likeButton.centerYAnchor.constraint(equalTo: questionUserInfo.centerYAnchor),
            likeButton.trailingAnchor.constraint(equalTo:  self.safeAreaLayoutGuide.trailingAnchor,constant: -40.0),
            likeButton.heightAnchor.constraint(equalToConstant: 30),
            likeButton.widthAnchor.constraint(equalToConstant: 30)
        ])
        NSLayoutConstraint.activate([
            likeNumberView.centerYAnchor.constraint(equalTo: likeButton.centerYAnchor),
            likeNumberView.trailingAnchor.constraint(equalTo: questionTitleView.trailingAnchor)
        ])
       NSLayoutConstraint.activate([
            questionContentView.leadingAnchor.constraint(equalTo: questionTitleView.leadingAnchor),
            questionContentView.trailingAnchor.constraint(equalTo: questionTitleView.trailingAnchor),
            questionContentView.topAnchor.constraint(equalTo:likeButton.bottomAnchor,constant: 10.0)
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
        NSLayoutConstraint.activate([
            questionDeleteButton.trailingAnchor.constraint(equalTo: questionTitleView.trailingAnchor),
            questionDeleteButton.centerYAnchor.constraint(equalTo: questionTimeView.centerYAnchor)
        ])
        NSLayoutConstraint.activate([
            questionEditButton.centerYAnchor.constraint(equalTo: questionTimeView.centerYAnchor),
            questionEditButton.trailingAnchor.constraint(equalTo: questionDeleteButton.leadingAnchor,constant: -5.0)
            
        ])
        NSLayoutConstraint.activate([
            tagView.topAnchor.constraint(equalTo: questionTimeView.bottomAnchor,constant: 5.0),
            tagView.leadingAnchor.constraint(equalTo: questionTitleView.leadingAnchor),
            tagView.trailingAnchor.constraint(equalTo: questionTitleView.trailingAnchor),
       
        ])
        NSLayoutConstraint.activate([
          answerButton.topAnchor.constraint(equalTo: tagView.bottomAnchor,constant: 10.0),
           answerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
          answerButton.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant:-20.0),
          answerButton.widthAnchor.constraint(equalTo:self.widthAnchor,multiplier: 0.5),
          answerButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    func setOnAnswerButtonClicked(onAnswerButtonClicked:@escaping()->()){
        self.onAnswerButtonClicked = onAnswerButtonClicked
    }
    @objc private func answerButtonClicked(_ sender: Any) {
        onAnswerButtonClicked?()
    }
    @objc func deleteButtonClicked(){
        onDeleteButtonClicked?()
    }
    @objc func likeButtonClicked(){
        onLikeButtonClicked?()
    }
    func configure(question:QuestionDetailModel,hasAnswers:Bool){
        
        questionTitleView.text = question.title
        questionTimeView.text = question.createdAt
        questionContentView.text = question.content
        questionUserInfo.text = question.username
        if question.close{
            answerButton.setImage(UIImage(named:"questionSelected"),for:.normal)
            answerButton.isEnabled = false
            answerButton.backgroundColor = UIColor(red: 209/255, green: 206/255, blue: 206/255, alpha: 1)
        }
        else{
            answerButton.setImage(UIImage(named:"AnswerButton"), for: .normal)
            answerButton.isEnabled = true
            answerButton.backgroundColor = BLUE_COLOR
        }
        likeNumberView.text = String(question.likeNumber)
        imageStackView.safelyRemoveArrangedSubviews()
        for image in question.photos{
            let imageView = UIImageView()
           
            imageStackView.addArrangedSubview(imageView)
            imageView.kf.setImage(with:URL(string:image)!){ [self]result in
                imageView.contentMode = .scaleAspectFit
               
                NSLayoutConstraint.activate([
                    imageView.widthAnchor.constraint(lessThanOrEqualToConstant: imageStackView.frame.width),
                    imageView.widthAnchor.constraint(equalTo:imageView.heightAnchor,multiplier: imageView.image!.size.width/imageView.image!.size.height)
                ])
                onImageLoaded?()
                layoutIfNeeded()
            }
            
        }
        if let accessToken = UserDefaults.standard.string(forKey: "accessToken"){
            let username = UserDefaults.standard.string(forKey: "username")!
            questionEditButton.isHidden = username != question.username || hasAnswers
            questionDeleteButton.isHidden = username != question.username || hasAnswers
        }
        else{
            questionEditButton.isHidden = true
            questionDeleteButton.isHidden = true
        }
        tags = question.tag
        tagView.reloadData()
        setLikeButton(like: question.liked)
    }
    func setLikeButton(like:Bool){
        if like{
            likeButton.setImage(systemName: "heart.fill", color: .red)
        }
        else{
            likeButton.setImage(systemName: "heart", color: .red)
        }
    }
    
}
extension QuestionView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(tags.count)
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailTagViewCell.identifier, for: indexPath) as? DetailTagViewCell else {
            return UICollectionViewCell()
        }
        print("cell")
        cell.tagLabel.text = "#" + self.tags[indexPath.row]
        return cell
    }
    
    
}
extension QuestionView:UICollectionViewDelegate{
    
}
extension QuestionView:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
            let label = UILabel()
            label.text = "#" + self.tags[indexPath.row]
            label.font = .systemFont(ofSize: 18)
            label.sizeToFit()
            let cellWidth = label.frame.width
            print("width")
            return CGSize(width: cellWidth, height: 22)
        
        
    }
}

class AnswerProfileView:UIView{

  
    
    var answerUserView:UILabel!
    var recentAnswerTime:UILabel!
    var profilePicture:UIImageView!
    override init(frame:CGRect){
        super.init(frame:frame)
        setLayout()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setLayout(){
        
        self.layer.borderColor = CGColor(gray: 242/255, alpha: 1)
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 10
       
        self.layer.masksToBounds = false
        answerUserView = UILabel()
        answerUserView.text = "impri"
        answerUserView.textColor = .black
        answerUserView.font = UIFont.boldSystemFont(ofSize: 20)
    
        recentAnswerTime = UILabel()
        recentAnswerTime.text = "2022.12.28"
        recentAnswerTime.textColor = .gray
        
        profilePicture = UIImageView(image:UIColor.yellow.image(CGSize(width: 50, height: 50)))
        profilePicture.layer.cornerRadius = 25
        profilePicture.clipsToBounds = true
        
        answerUserView.translatesAutoresizingMaskIntoConstraints = false
        recentAnswerTime.translatesAutoresizingMaskIntoConstraints = false
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(answerUserView)
        addSubview(recentAnswerTime)
        addSubview(profilePicture)
        
    }
    func setConstraint(){
        NSLayoutConstraint.activate([
            answerUserView.topAnchor.constraint(equalTo: self.topAnchor,constant:5.0),
            answerUserView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 5.0)
        ])
        NSLayoutConstraint.activate([
            recentAnswerTime.topAnchor.constraint(equalTo: answerUserView.bottomAnchor,constant: 5.0),
            recentAnswerTime.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 5.0),
            recentAnswerTime.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -20.0)
        ])
        NSLayoutConstraint.activate([
            profilePicture.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            profilePicture.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -5.0),
            
        ])
    }
    func configure(answer:AnswerDetailModel){
        answerUserView.text = answer.username
        recentAnswerTime.text = answer.userRecentAnswerDate
        
    }
}
class AnswerTableCell:UITableViewCell{
    static let ID = "AnswerTableCell"
    
    var imageURL:[String] = []
  
    
    var lineAtTop:UIView!
    var profile:AnswerProfileView!
    var answerContentView:UILabel!
    var likeButton:UIButton!
    var dislikeButton:UIButton!
    var answerPicture:UIImageView!
    var imageStackView:UIStackView!
    var answerImages:[UIImage] = []
    var answerTimeView:UILabel!
    var answerEditButton:UIButton!
    var answerDeleteButton:UIButton!
    var answerChoiceButton:UIButton!
    var onSelectButtonPressed:(()->())?
    var onAgreeButtonPressed:(()->())?
    var onDisagreeButtonPressed:(()->())?
    var onDeleteButtonPressed:(()->())?
    var onImageLoaded:(()->())?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setLayout(){
        lineAtTop = UIView()
        lineAtTop.backgroundColor = UIColor(red: 235/255.0, green: 235/255.0, blue: 235/255.0, alpha: 1)
     
        profile = AnswerProfileView()
        
        answerContentView = UILabel()
        answerContentView.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        answerContentView.font = answerContentView.font.withSize(20)
        answerContentView.numberOfLines = 0
        answerContentView.lineBreakMode = .byCharWrapping
        
        answerTimeView = UILabel()
        answerTimeView.text = "1분 전"
        answerTimeView.textColor = .lightGray
        
        answerPicture = UIImageView(image: UIColor.green.image(CGSize(width: 60, height: 40)))
        answerPicture.contentMode = .scaleAspectFit
        
       
        imageStackView = UIStackView()
        imageStackView.axis = .vertical
        imageStackView.distribution = .equalSpacing
        imageStackView.alignment = .leading
        imageStackView.spacing = 20
        
        
        likeButton = UIButton()
        likeButton.setTitle("2", for: .normal)
        likeButton.setTitleColor(.black, for: .normal)
        likeButton.setImage(systemName: "hand.thumbsup", color: UIColor.black)
        likeButton.contentHorizontalAlignment = .fill
        likeButton.contentVerticalAlignment = .fill
        likeButton.imageView?.contentMode = .scaleAspectFit
        dislikeButton = UIButton()
        dislikeButton.setTitle("3", for: .normal)
        dislikeButton.setImage(systemName: "hand.thumbsdown", color: UIColor.black)
        dislikeButton.setTitleColor(.black, for: .normal)
        dislikeButton.contentHorizontalAlignment = .fill
        dislikeButton.contentVerticalAlignment = .fill
        dislikeButton.imageView?.contentMode = .scaleAspectFit
        answerDeleteButton = UIButton()
        answerDeleteButton.setTitle("삭제", for: .normal)
        answerDeleteButton.setTitleColor(.black, for: .normal)
        
        answerEditButton = UIButton()
        answerEditButton.setTitle("수정", for: .normal)
        answerEditButton.setTitleColor(.black, for: .normal)
        answerChoiceButton = UIButton()
        profile.translatesAutoresizingMaskIntoConstraints = false
        answerContentView.translatesAutoresizingMaskIntoConstraints = false
        answerTimeView.translatesAutoresizingMaskIntoConstraints = false
        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        answerEditButton.translatesAutoresizingMaskIntoConstraints = false
        answerDeleteButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        dislikeButton.translatesAutoresizingMaskIntoConstraints = false
        answerChoiceButton.translatesAutoresizingMaskIntoConstraints = false
        lineAtTop.translatesAutoresizingMaskIntoConstraints = false
        
        answerChoiceButton.addTarget(self, action: #selector(onSelect), for: .touchDown)
        likeButton.addTarget(self, action: #selector(onAgree), for: .touchDown)
        dislikeButton.addTarget(self, action: #selector(onDisagree), for: .touchDown)
        answerDeleteButton.addTarget(self, action: #selector(onDelete), for: .touchDown)
        contentView.addSubview(lineAtTop)
        contentView.addSubview(profile)
        contentView.addSubview(answerContentView)
        contentView.addSubview(answerTimeView)
        contentView.addSubview(imageStackView)
        contentView.addSubview(answerEditButton)
        contentView.addSubview(answerDeleteButton)
        contentView.addSubview(likeButton)
        contentView.addSubview(answerChoiceButton)
        contentView.addSubview(dislikeButton)
    }
    func setConstraints(){
        NSLayoutConstraint.activate([
            lineAtTop.topAnchor.constraint(equalTo: contentView.topAnchor),
            lineAtTop.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            lineAtTop.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            lineAtTop.heightAnchor.constraint(equalToConstant: 2.0)
        ])
        NSLayoutConstraint.activate([
            profile.topAnchor.constraint(equalTo: lineAtTop.bottomAnchor,constant: 5.0),
            profile.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant:20.0),
            //profile.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20.0)
        ])
        NSLayoutConstraint.activate([
            dislikeButton.topAnchor.constraint(equalTo: profile.topAnchor),
            dislikeButton.bottomAnchor.constraint(equalTo: profile.bottomAnchor),
            dislikeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -5.0),
           
            dislikeButton.widthAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            likeButton.topAnchor.constraint(equalTo: profile.topAnchor),
            likeButton.bottomAnchor.constraint(equalTo: profile.bottomAnchor),
            likeButton.trailingAnchor.constraint(equalTo: dislikeButton.leadingAnchor,constant: -5.0),
            likeButton.leadingAnchor.constraint(equalTo: profile.trailingAnchor,constant: 5.0),
          
            likeButton.widthAnchor.constraint(equalToConstant: 50)
        ])
        NSLayoutConstraint.activate([
            answerContentView.topAnchor.constraint(equalTo: profile.bottomAnchor,constant: 5.0),
            answerContentView.leadingAnchor.constraint(equalTo: profile.leadingAnchor),
            answerContentView.trailingAnchor.constraint(equalTo: dislikeButton.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            imageStackView.topAnchor.constraint(equalTo: answerContentView.bottomAnchor,constant: 5.0),
            imageStackView.leadingAnchor.constraint(equalTo: answerContentView.leadingAnchor),
            imageStackView.trailingAnchor.constraint(equalTo: answerContentView.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            answerTimeView.topAnchor.constraint(equalTo: imageStackView.bottomAnchor,constant: 5.0),
            answerTimeView.leadingAnchor.constraint(equalTo: answerContentView.leadingAnchor)
        ])
        NSLayoutConstraint.activate([
            answerChoiceButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            answerChoiceButton.topAnchor.constraint(equalTo: answerTimeView.bottomAnchor,constant: 5.0),
            answerChoiceButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10.0),
            answerChoiceButton.widthAnchor.constraint(equalTo:contentView.widthAnchor,multiplier:0.4)
           
        ])
        NSLayoutConstraint.activate([
            answerDeleteButton.topAnchor.constraint(equalTo: answerTimeView.topAnchor),
            answerDeleteButton.bottomAnchor.constraint(equalTo: answerTimeView.bottomAnchor),
            answerDeleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -5.0)
        ])
        NSLayoutConstraint.activate([
            answerEditButton.topAnchor.constraint(equalTo: answerTimeView.topAnchor),
            answerEditButton.bottomAnchor.constraint(equalTo: answerTimeView.bottomAnchor),
            answerEditButton.trailingAnchor.constraint(equalTo: answerDeleteButton.leadingAnchor,constant: -5.0)
        ])
    }
    func setIsChosen(isChosen:Bool){
        let redColor = UIColor(red: 253/255, green: 95/255, blue: 86/255, alpha: 1)
        if(isChosen){
            let checkImage = UIImage(systemName: "checkmark.circle")?.withTintColor(redColor,renderingMode: .alwaysOriginal)
            
            answerChoiceButton.isEnabled = false
            answerChoiceButton.backgroundColor = .white
            answerChoiceButton.setTitle("질문자 채택", for: .normal)
            answerChoiceButton.setTitleColor(redColor, for: .normal)
            answerChoiceButton.titleLabel!.font = answerChoiceButton.titleLabel!.font.withSize(20)
            answerChoiceButton.setImage(checkImage, for: .normal)
          
        }
        else{
            answerChoiceButton.isEnabled = true
            answerChoiceButton.backgroundColor = redColor
            answerChoiceButton.setTitle("채택하기", for: .normal)
            answerChoiceButton.titleLabel!.font = answerChoiceButton.titleLabel!.font.withSize(20)
            answerChoiceButton.setTitleColor(.white, for: .normal)
            answerChoiceButton.setImage(nil, for: .normal)
            
        }
    }
    func configure(answer:AnswerDetailModel,question:QuestionDetailModel?){
        
        answerTimeView.text = answer.createdAt
        answerContentView.text = answer.content
        likeButton.setTitle(String(answer.agree), for: .normal)
        dislikeButton.setTitle(String(answer.disagree),for:.normal)
        profile.configure(answer:answer)
        /*setIsChosen(isChosen: answer.selected)
        if question == nil{
            answerChoiceButton.isHidden = true
        }
        else{
            answerChoiceButton.isHidden = question!.close && !answer.selected
        }*/
        configureButtons(question: question, answer: answer)
        configurePhotos(answer: answer)
    
     /*   if let accessToken = UserDefaults.standard.string(forKey: "accessToken"){
            let username = UserDefaults.standard.string(forKey: "username")!
            answerEditButton.isHidden =  username != answer.username || answer.selected
            answerDeleteButton.isHidden =  username != answer.username || answer.selected
            answerChoiceButton.isHidden = username != question?.username && !answer.selected
        }
        else{
            answerEditButton.isHidden = true
            answerDeleteButton.isHidden = true
            if !answer.selected{
                answerChoiceButton.isHidden = true
            }
        }*/
    }
    func configurePhotos(answer:AnswerDetailModel){
        if answer.photos != imageURL{
            imageURL = answer.photos
            imageStackView.safelyRemoveArrangedSubviews()
            
            for image in answer.photos{
                let imageView = UIImageView()
                
                imageStackView.addArrangedSubview(imageView)
                
                imageView.kf.setImage(with:URL(string:image)!){ [self]result in
                    
                    imageView.contentMode = .scaleAspectFit
                    
                    NSLayoutConstraint.activate([
                        imageView.widthAnchor.constraint(lessThanOrEqualToConstant: imageStackView.frame.width),
                        imageView.widthAnchor.constraint(equalTo:imageView.heightAnchor,multiplier: imageView.image!.size.width/imageView.image!.size.height)
                    ])
                    onImageLoaded?()
                    
                }
            }
        }
    }
    func configureButtons(question:QuestionDetailModel?,answer:AnswerDetailModel){
        setIsChosen(isChosen: answer.selected)
        if question == nil{
            answerChoiceButton.isHidden = true
        }
        else{
            answerChoiceButton.isHidden = question!.close && !answer.selected
        }
        if let accessToken = UserDefaults.standard.string(forKey: "accessToken"){
            let username = UserDefaults.standard.string(forKey: "username")!
            answerEditButton.isHidden =  username != answer.username || answer.selected
            answerDeleteButton.isHidden =  username != answer.username || answer.selected
            answerChoiceButton.isHidden = username != question?.username && !answer.selected
        }
        else{
            answerEditButton.isHidden = true
            answerDeleteButton.isHidden = true
            if !answer.selected{
                answerChoiceButton.isHidden = true
            }
        }
        if answer.userIsAgreed == nil{
            likeButton.setImage(systemName: "hand.thumbsup", color: .black)
            dislikeButton.setImage(systemName: "hand.thumbsdown", color: .black)
        }
        else if answer.userIsAgreed!{
           likeButton.setImage(systemName: "hand.thumbsup", color: .red)
           dislikeButton.setImage(systemName: "hand.thumbsdown", color: .black)
        }
        else {
            likeButton.setImage(systemName: "hand.thumbsup", color: .black)
            dislikeButton.setImage(systemName: "hand.thumbsdown", color: .blue)
        }
    }
    @objc func onSelect(){
        onSelectButtonPressed?()
    }
    @objc func onAgree(){
        onAgreeButtonPressed?()
    }
    @objc func onDisagree(){
        onDisagreeButtonPressed?()
    }
    @objc func onDelete(){
        onDeleteButtonPressed?()
    }
    
}
class QuestionDetailViewController:UIViewController{
    var bag = DisposeBag()
    var answerTableView:UITableView!
    var questionView = QuestionView()
    var headerView : UITableViewHeaderFooterView!
    var viewModel:QuestionDetailViewModel
    init(viewModel:QuestionDetailViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
      
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
            self.viewModel.refresh()
     
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if let headerView = answerTableView.tableHeaderView {

            let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            var headerFrame = headerView.frame

            //Comparison necessary to avoid infinite loop
            if height != headerFrame.size.height {
                headerFrame.size.height = height
                headerView.frame = headerFrame
                answerTableView.tableHeaderView = headerView
            }
            headerView.translatesAutoresizingMaskIntoConstraints = false
            
        }
    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        viewModel.refresh()
//    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .white
        viewModel.refresh()
        setLayout()
        setConstraint()
      
        // Do any additional setup after loading the view.
        viewModel.question.subscribe(onNext: {[weak self]
            question in
            if self==nil{return}
            if let question{
                self!.questionView.configure(question:question,hasAnswers:self!.viewModel.answers.value.count != 0)
                
            }
            
        }).disposed(by: bag)
        viewModel.answers.subscribe(onNext: {[weak self]
            answers in
          
            if self==nil{return}
            if self!.viewModel.question.value == nil{return}
            self!.questionView.configure(question:self!.viewModel.question.value!,hasAnswers:answers.count != 0)
                
            
            
        }).disposed(by: bag)
     
       viewModel.answers.bind(to:answerTableView.rx.items(cellIdentifier: AnswerTableCell.ID)){index,model,cell in
       
           (cell as! AnswerTableCell).onImageLoaded = {
               self.answerTableView.reloadData()
           }
           (cell as! AnswerTableCell).configure(answer:model,question:self.viewModel.question.value)
          
           self.viewModel.question.subscribe(onNext: {
                 question in
               if let question{
                    
                   (cell as! AnswerTableCell).configure(answer:model,question:question)
               }
           }).disposed(by: self.bag)
            (cell as! AnswerTableCell).onSelectButtonPressed = { [self] in
                print("pressed")
                self.viewModel.selectAnswer(index: index).subscribe(onSuccess: {_ in
                    viewModel.refresh()
                },onError:{
                    _ in
                    print("채택 실패")
                })
                
            }
           (cell as! AnswerTableCell).onAgreeButtonPressed = {[self]
               if let accessToken = UserDefaults.standard.string(forKey: "accessToken"){
                   self.viewModel.agreeAnswer(index: index, isAgree: true).subscribe(onSuccess:{
                       _ in
                       self.viewModel.refresh()
                   })
               }
               else{
                   self.showLoginAlert(onLogin: {
                       self.tabBarController?.navigationController?.popViewController(animated: true)
                   })
               }
           }
           (cell as! AnswerTableCell).onDisagreeButtonPressed = {[self]
               if let accessToken = UserDefaults.standard.string(forKey: "accessToken"){
                   self.viewModel.agreeAnswer(index: index, isAgree: false).subscribe(onSuccess:{
                       _ in
                       self.viewModel.refresh()
                   }).disposed(by: self.bag)
               }
               else{
                   self.showLoginAlert(onLogin: {
                       self.tabBarController?.navigationController?.popViewController(animated: true)
                   })
               }
           }
           (cell as! AnswerTableCell).onDeleteButtonPressed = {
               [self]
               self.viewModel.deleteAnswer(index: index).subscribe(onSuccess: { _ in
                   self.viewModel.refresh()
               }).disposed(by: self.bag)
           }
            
        }.disposed(by: bag)
        
    }
    func setLayout(){
   
        navigationController?.isNavigationBarHidden = false
        
        
        answerTableView = UITableView(frame: .zero, style: .grouped)
        answerTableView.delegate = self
     
        answerTableView.register(AnswerTableCell.self, forCellReuseIdentifier: AnswerTableCell.ID)
        answerTableView.backgroundColor = .white
        answerTableView.sectionHeaderHeight = UITableView.automaticDimension
        answerTableView.rowHeight = UITableView.automaticDimension
    
        answerTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(answerTableView)
        
    }
    func setConstraint(){
       
        NSLayoutConstraint.activate([
            answerTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            answerTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            answerTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            answerTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
extension QuestionDetailViewController:UITableViewDelegate{
  
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        questionView.onImageLoaded = {
            tableView.reloadData()
        }
        questionView.setOnAnswerButtonClicked(){[weak self] in
            if UserDefaults.standard.bool(forKey: "isLogin"){
                var vc = WritingAnswerViewController()
                vc.questionID = (self?.viewModel.questionID)!
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            else{
                self?.showLoginAlert{
                    self?.tabBarController?.navigationController?.popViewController(animated: false){
                        var vc = WritingAnswerViewController()
                        vc.questionID = (self?.viewModel.questionID)!
                        self?.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
        }
        questionView.onLikeButtonClicked = {
            if UserDefaults.standard.bool(forKey: "isLogin"){
                self.viewModel.likeQuestion().subscribe(onSuccess:{
                    _ in
                    self.viewModel.refresh()
                })
            }
            else{
                self.showLoginAlert{
                    self.tabBarController?.navigationController?.popViewController(animated: true)
                }
            }
        }
        questionView.onDeleteButtonClicked = {
            self.viewModel.deleteQuestion().subscribe(onSuccess:{[weak self]
                _ in
                self?.navigationController?.popViewController(animated: true)
            })
        }
        questionView.translatesAutoresizingMaskIntoConstraints = false
        let headerView = UITableViewHeaderFooterView()
        headerView.contentView.addSubview(questionView)
      
        NSLayoutConstraint.activate([
            questionView.leadingAnchor.constraint(equalTo: headerView.contentView.leadingAnchor),
            questionView.topAnchor.constraint(equalTo: headerView.contentView.topAnchor),
            questionView.bottomAnchor.constraint(equalTo: headerView.contentView.bottomAnchor),
            questionView.trailingAnchor.constraint(equalTo: headerView.contentView.trailingAnchor)
        ])
        return headerView
    }
    func showLoginAlert(onLogin:@escaping(()->())){
         let loginAction = UIAlertAction(title: "로그인", style: .default,handler: {[weak self]
             setAction in
             let appearance = UINavigationBarAppearance()
             appearance.configureWithOpaqueBackground()
             appearance.backgroundColor = UIColor(named:"BackgroundColor")
             appearance.shadowColor = .clear
             self?.tabBarController?.navigationController?.navigationBar.standardAppearance = appearance
             self?.tabBarController?.navigationController?.navigationBar.scrollEdgeAppearance = appearance
           
             let vc = LoginViewController()
           
             vc.onLogin = onLogin
                 
                
             
             let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
             backBarButtonItem.tintColor = UIColor(named: "MainColor")
             self?.tabBarController?.navigationItem.backBarButtonItem = backBarButtonItem
             self?.tabBarController?.navigationController?.pushViewController(vc, animated: true)
             self?.tabBarController?.navigationController?.setNavigationBarHidden(false, animated: false)
             
         })
         let cancelAction = UIAlertAction(title:"취소",style:.default)
         let alert = UIAlertController(title:nil,message: "로그인이 필요합니다",preferredStyle: .alert)
      alert.addAction(loginAction)
          alert.addAction(cancelAction)
          self.present(alert,animated: false)
      }
 
    
}
extension UIColor {//for single color image
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
extension UINavigationController {
    func popViewController(
        animated: Bool,
        completion: @escaping () -> Void)
    {
        popViewController(animated: animated)

        guard animated, let coordinator = transitionCoordinator else {
            DispatchQueue.main.async { completion() }
            return
        }

        coordinator.animate(alongsideTransition: nil) { _ in completion() }
    }
}

extension UIStackView {

    func safelyRemoveArrangedSubviews() {

        // Remove all the arranged subviews and save them to an array
        let removedSubviews = arrangedSubviews.reduce([]) { (sum, next) -> [UIView] in
            self.removeArrangedSubview(next)
            return sum + [next]
        }

        // Deactive all constraints at once
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))

        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }

}
