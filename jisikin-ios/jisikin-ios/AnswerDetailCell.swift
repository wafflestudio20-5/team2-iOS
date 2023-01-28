import Foundation
import UIKit
import RxSwift
import RxCocoa
import Kingfisher


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
        
//        self.layer.borderColor = UIColor.init(red:225/255,green:225/255,blue:225/255,alpha:1).cgColor
//        self.layer.borderWidth = 2
        self.layer.cornerRadius = 9
        
        self.layer.masksToBounds = false
        backgroundColor = .white
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 4
        layer.shadowColor = UIColor.gray.cgColor
        answerUserView = UILabel()
        answerUserView.textColor = .black
        answerUserView.font = UIFont.boldSystemFont(ofSize: 20)
        
        recentAnswerTime = UILabel()
        recentAnswerTime.textColor = .gray
        
        profilePicture = UIImageView(image:UIColor.yellow.image(CGSize(width: 50, height: 50)))
        profilePicture.layer.cornerRadius = 25
        profilePicture.clipsToBounds = true
        profilePicture.layer.borderColor = UIColor.clear.cgColor
        profilePicture.layer.borderWidth = 1
        profilePicture.contentMode = .scaleAspectFill
        answerUserView.translatesAutoresizingMaskIntoConstraints = false
        recentAnswerTime.translatesAutoresizingMaskIntoConstraints = false
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(answerUserView)
        addSubview(recentAnswerTime)
        addSubview(profilePicture)
        
    }
    func setConstraint(){
        NSLayoutConstraint.activate([
            answerUserView.centerYAnchor.constraint(equalTo: self.centerYAnchor,constant:-13),
            answerUserView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10)
        ])
        NSLayoutConstraint.activate([
            recentAnswerTime.centerYAnchor.constraint(equalTo: self.centerYAnchor,constant: 13),
            recentAnswerTime.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10),
            recentAnswerTime.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -20.0)
        ])
        NSLayoutConstraint.activate([
            profilePicture.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            profilePicture.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -5.0),
            profilePicture.widthAnchor.constraint(equalToConstant: 50),
            profilePicture.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    func configure(answer:AnswerDetailModel){
        answerUserView.text = answer.username
        recentAnswerTime.text = "최근답변 \(answer.userRecentAnswerDate)"
        if answer.profileImagePath != nil{
            print(answer.profileImagePath)
        
            profilePicture.kf.setImage(with:URL(string:answer.profileImagePath!)!)
        }
    }
}
class AnswerTableCell:UITableViewCell{
    static let ID = "AnswerTableCell"
    
    
    var agreeNumber = 0
    var disagreeNumber = 0
    var agreed:Bool? = nil
    
   
    var imageURL:[String] = []
    
    var lineAtTop:UIView!
    var selectedLabel:UILabel!
    var profile:AnswerProfileView!
    var answerContentView:UILabel!
    var answerPicture:UIImageView!
    var imageStackView:UIStackView!
    var answerImages:[UIImage] = []
    var answerTimeView:UILabel!
    var answerEditButton:UIButton!
    var answerDeleteButton:UIButton!
    var answerChoiceButton:UIButton!
    var answerSelectedImage:UIImageView!
    var likeView:QuestionLikeView!
    var dislikeView:QuestionLikeView!
    var onSelectButtonPressed:(()->())?
    var onAgreeButtonPressed:(()->())?
    var onDisagreeButtonPressed:(()->())?
    var onDeleteButtonPressed:(()->())?
    var onEditButtonPressed:(()->())?
    var onImageLoaded:(()->())?
    
    var lineAtTopHeightConstraint:NSLayoutConstraint!
    var selectedLabelHeightConstraint:NSLayoutConstraint!
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setLayout()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setLayout(){
        lineAtTop = UIView()
        lineAtTop.backgroundColor = UIColor(red: 235/255.0, green: 235/255.0, blue: 235/255.0, alpha: 1)
        
        selectedLabel = UILabel()
        selectedLabel.textColor = UIColor(red:224/255, green: 108/255, blue: 97/255, alpha: 1)
        selectedLabel.text = "질문자 채택"
        selectedLabel.font = selectedLabel.font.withSize(10)
        profile = AnswerProfileView()
        
        answerContentView = UILabel()
        answerContentView.font = answerContentView.font.withSize(20)
        answerContentView.numberOfLines = 0
        answerContentView.lineBreakMode = .byCharWrapping
      
        answerTimeView = UILabel()
        answerTimeView.textColor = .lightGray
        
        answerPicture = UIImageView(image: UIColor.green.image(CGSize(width: 60, height: 40)))
        answerPicture.contentMode = .scaleAspectFit
        
        
        imageStackView = UIStackView()
        imageStackView.axis = .vertical
        imageStackView.distribution = .equalSpacing
        imageStackView.alignment = .leading
        imageStackView.spacing = 20
        
        
        
        answerDeleteButton = UIButton()
        answerDeleteButton.setTitle("삭제", for: .normal)
        answerDeleteButton.setTitleColor(.lightGray, for: .normal)
        
        answerEditButton = UIButton()
        answerEditButton.setTitle("수정", for: .normal)
        answerEditButton.setTitleColor(.lightGray, for: .normal)
        answerChoiceButton = UIButton()
        answerChoiceButton.setImage(UIImage(named: "selectedButton"), for: .normal)
        answerChoiceButton.contentMode = .scaleAspectFit
        answerChoiceButton.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        
        answerSelectedImage = UIImageView()
        answerSelectedImage.image = UIImage(named: "selectedAnswer")
        answerSelectedImage.contentMode = .scaleAspectFit
        likeView = QuestionLikeView()
        likeView.selectedImage = UIImage(systemName: "hand.thumbsup")!.withTintColor(.red,renderingMode:.alwaysOriginal)
        
        likeView.unSelectedImage = UIImage(systemName: "hand.thumbsup")!.withTintColor(.black,renderingMode:.alwaysOriginal)
        dislikeView = QuestionLikeView()
        dislikeView.selectedImage = UIImage(systemName: "hand.thumbsdown")!.withTintColor(.blue,renderingMode:.alwaysOriginal)
        dislikeView.unSelectedImage = UIImage(systemName: "hand.thumbsdown")!.withTintColor(.black,renderingMode:.alwaysOriginal)
        selectedLabel.translatesAutoresizingMaskIntoConstraints = false
        profile.translatesAutoresizingMaskIntoConstraints = false
        answerContentView.translatesAutoresizingMaskIntoConstraints = false
        answerTimeView.translatesAutoresizingMaskIntoConstraints = false
        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        answerEditButton.translatesAutoresizingMaskIntoConstraints = false
        answerDeleteButton.translatesAutoresizingMaskIntoConstraints = false
        answerSelectedImage.translatesAutoresizingMaskIntoConstraints = false
        answerChoiceButton.translatesAutoresizingMaskIntoConstraints = false
        lineAtTop.translatesAutoresizingMaskIntoConstraints = false
        likeView.translatesAutoresizingMaskIntoConstraints = false
        dislikeView.translatesAutoresizingMaskIntoConstraints = false
        
        answerChoiceButton.addTarget(self, action: #selector(onSelect), for: .touchDown)
        
        answerDeleteButton.addTarget(self, action: #selector(onDelete), for: .touchDown)
        answerEditButton.addTarget(self, action: #selector(onEdit), for: .touchDown)
        contentView.addSubview(lineAtTop)
        contentView.addSubview(selectedLabel)
        contentView.addSubview(profile)
        contentView.addSubview(answerContentView)
        contentView.addSubview(answerTimeView)
        contentView.addSubview(imageStackView)
        contentView.addSubview(answerEditButton)
        contentView.addSubview(answerDeleteButton)
        
        contentView.addSubview(answerChoiceButton)
        contentView.addSubview(answerSelectedImage)
        
        contentView.addSubview(likeView)
        contentView.addSubview(dislikeView)
        
    }
    func setConstraints(){
        NSLayoutConstraint.activate([
            lineAtTop.topAnchor.constraint(equalTo: contentView.topAnchor),
            lineAtTop.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            lineAtTop.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            //   lineAtTop.heightAnchor.constraint(equalToConstant: 2.0)
        ])
        lineAtTopHeightConstraint = lineAtTop.heightAnchor.constraint(equalToConstant: 2.0)
        lineAtTopHeightConstraint.isActive = true
        NSLayoutConstraint.activate([
            selectedLabel.topAnchor.constraint(equalTo: lineAtTop.bottomAnchor,constant:5.0),
            selectedLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant:20.0)
            
        ])
        NSLayoutConstraint.activate([
            profile.topAnchor.constraint(equalTo: selectedLabel.bottomAnchor,constant: 5.0),
            profile.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant:20.0),
            profile.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -20.0)
        ])
        
        NSLayoutConstraint.activate([
            answerContentView.topAnchor.constraint(equalTo: profile.bottomAnchor,constant: 13.0),
            answerContentView.leadingAnchor.constraint(equalTo: profile.leadingAnchor),
            answerContentView.trailingAnchor.constraint(equalTo: profile.trailingAnchor)
            
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
            likeView.topAnchor.constraint(equalTo: answerTimeView.bottomAnchor,constant:5.0),
            likeView.leadingAnchor.constraint(equalTo: answerTimeView.leadingAnchor)
        ])
        NSLayoutConstraint.activate([
            dislikeView.topAnchor.constraint(equalTo: likeView.topAnchor),
            dislikeView.bottomAnchor.constraint(equalTo: likeView.bottomAnchor),
            dislikeView.leadingAnchor.constraint(equalTo: likeView.trailingAnchor,constant:-2.0)
        ])
        NSLayoutConstraint.activate([
            answerChoiceButton.trailingAnchor.constraint(equalTo: answerContentView.trailingAnchor),
            answerChoiceButton.topAnchor.constraint(equalTo: likeView.topAnchor),
            answerChoiceButton.bottomAnchor.constraint(equalTo: likeView.bottomAnchor),
            answerChoiceButton.leadingAnchor.constraint(equalTo: dislikeView.trailingAnchor,constant:60.0)
            
            
        ])
        answerChoiceButton.imageView?.backgroundColor = UIColor.init(red: 254/255, green: 126/255, blue: 117/255, alpha: 1)
        answerChoiceButton.imageView?.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            answerDeleteButton.topAnchor.constraint(equalTo: answerTimeView.topAnchor),
            answerDeleteButton.bottomAnchor.constraint(equalTo: answerTimeView.bottomAnchor),
            answerDeleteButton.trailingAnchor.constraint(equalTo: profile.trailingAnchor)
        ])
        NSLayoutConstraint.activate([
            answerEditButton.topAnchor.constraint(equalTo: answerTimeView.topAnchor),
            answerEditButton.bottomAnchor.constraint(equalTo: answerTimeView.bottomAnchor),
            answerEditButton.trailingAnchor.constraint(equalTo: answerDeleteButton.leadingAnchor,constant: -5.0)
        ])
        NSLayoutConstraint.activate([
            answerSelectedImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            answerSelectedImage.topAnchor.constraint(equalTo: likeView.bottomAnchor,constant:5.0),
            answerSelectedImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant:-5.0),
            answerSelectedImage.widthAnchor.constraint(equalTo: contentView.widthAnchor,multiplier:0.4)
        ])
        
        
    }
    
    func configure(answer:AnswerDetailModel,question:QuestionDetailModel?){
        if answer.selected{
            lineAtTop.backgroundColor = .init(red: 224/255, green: 108/255, blue: 97/255, alpha: 1)
            lineAtTopHeightConstraint.constant = 4.0
            selectedLabel.isHidden = false
            
        }
        else{
            lineAtTop.backgroundColor = .gray
            lineAtTopHeightConstraint.constant = 2.0
            selectedLabel.isHidden = true
        }
        answerTimeView.text = answer.createdAt
        answerContentView.text = answer.content
        answerContentView.setLineSpacing(spacing: 4.0)
        profile.configure(answer:answer)
        agreed = answer.userIsAgreed
        agreeNumber = answer.agree
        disagreeNumber = answer.disagree
        likeView.configure(isLike: answer.userIsAgreed == true, likeCount: answer.agree)
        dislikeView.configure(isLike: answer.userIsAgreed == false, likeCount: answer.disagree)
        
        configureButtons(question: question, answer: answer)
        configurePhotos(answer: answer)
        
    }
    func configurePhotos(answer:AnswerDetailModel){
        
        imageURL = answer.photos
        imageStackView.safelyRemoveArrangedSubviews()
        
        for image in answer.photos{
            let imageView = UIImageView()
            
            imageStackView.addArrangedSubview(imageView)
            
            imageView.kf.setImage(with:URL(string:image)!){ [weak self]result in
                
                if self == nil{return}
                if case .failure = result{
                    return
                }
              
                
                imageView.contentMode = .scaleAspectFit
                
                NSLayoutConstraint.activate([
                    imageView.widthAnchor.constraint(lessThanOrEqualToConstant: self!.imageStackView.frame.width),
                    imageView.widthAnchor.constraint(equalTo:imageView.heightAnchor,multiplier: imageView.image!.size.width/imageView.image!.size.height)
                ])
                print("image loaded")
             
                
                self!.onImageLoaded?()
                
                
            }
        }
        
        
        
    }
    
    func configureButtons(question:QuestionDetailModel?,answer:AnswerDetailModel){
        
        if question == nil{
            answerEditButton.isHidden = true
            answerDeleteButton.isHidden = true
            answerChoiceButton.isHidden = true
            return
        }
        
        
        answerSelectedImage.isHidden = !answer.selected
        
        if let accessToken = UserDefaults.standard.string(forKey: "accessToken"){
            let username = UserDefaults.standard.string(forKey: "username")!
            answerEditButton.isHidden =  username != answer.username || question!.close
            answerDeleteButton.isHidden =  username != answer.username || question!.close
            answerChoiceButton.isHidden = question!.close || username != question!.username
        }
        else{
            answerEditButton.isHidden = true
            answerDeleteButton.isHidden = true
            answerChoiceButton.isHidden = true
        }
    }
    
    func setOnAgreeButtonClicked(on:@escaping()->()){
        likeView.onLike = on
    }
    func setOnDisAgreeButtonClicked(on:@escaping()->()){
        dislikeView.onLike = on
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
    @objc func onEdit(){
        onEditButtonPressed?()
    }
    func pressAgree(){
        if agreed == true{
            agreed = nil
            agreeNumber -= 1
        }
        else if agreed == false{
            agreed = true
            agreeNumber += 1
            disagreeNumber -= 1
        }
        else{
            agreed = true
            agreeNumber += 1
        }
        
        likeView.configure(isLike: agreed == true, likeCount: agreeNumber)
        dislikeView.configure(isLike: agreed == false, likeCount: disagreeNumber)
    }
    func pressDisagree(){
        if agreed == true{
            agreed = false
            agreeNumber -= 1
            disagreeNumber += 1
        }
        else if agreed == false{
            agreed = nil
            disagreeNumber -= 1
        }
        else{
            agreed = false
            disagreeNumber += 1
        }
        likeView.configure(isLike: agreed == true, likeCount: agreeNumber)
        dislikeView.configure(isLike: agreed == false, likeCount: disagreeNumber)
    }
    
}

