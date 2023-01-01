//
//  QuestionDetailViewController.swift
//  jisikin-ios
//
//  Created by 박정헌 on 2022/12/29.
//

import Foundation
import UIKit

class QuestionView:UIView{
    var questionTitleView:UILabel!
    var questionUserInfo:UILabel!
    var questionContentView:UILabel!
    var questionTimeView:UILabel!
    var questionEditButton:UIButton!
    var questionDeleteButton:UIButton!
    var likeButton:UIButton!
    var answerButton:UIButton!
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
        
        likeButton = UIButton()
        likeButton.setTitle("15", for: .normal)
        likeButton.setTitleColor(.black, for: .normal)
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        
        questionTimeView = UILabel()
        questionTimeView.text = "2022.12.16"
        questionTimeView.textColor = .black
        questionEditButton = UIButton()
        questionEditButton.setTitle("수정", for: .normal)
        questionEditButton.setTitleColor(.gray, for: .normal)
        
        questionDeleteButton = UIButton()
        questionDeleteButton.setTitle("삭제", for: .normal)
        questionDeleteButton.setTitleColor(.gray, for: .normal)
        
        answerButton = UIButton()
        answerButton.backgroundColor = BLUE_COLOR
        answerButton.setTitle("답변하기", for: .normal)
        
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
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        questionTimeView.translatesAutoresizingMaskIntoConstraints = false
        questionEditButton.translatesAutoresizingMaskIntoConstraints = false
        questionDeleteButton.translatesAutoresizingMaskIntoConstraints = false
        answerButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(questionTitleView)
        addSubview(questionUserInfo)
        addSubview(questionContentView)
        addSubview(likeButton)
        addSubview(imageStackView)
        addSubview(questionTimeView)
        addSubview(questionEditButton)
        addSubview(questionDeleteButton)
        addSubview(answerButton)
        
    }
    func setConstraint(){
        NSLayoutConstraint.activate([
            questionTitleView.topAnchor.constraint(equalTo: self.topAnchor,constant: 0),
            questionTitleView.leadingAnchor.constraint(equalTo:  self.leadingAnchor,constant: 20.0),
            questionTitleView.trailingAnchor.constraint(equalTo:  self.trailingAnchor,constant: -20.0)
        ])
        NSLayoutConstraint.activate([
            questionUserInfo.leadingAnchor.constraint(equalTo: questionTitleView.leadingAnchor),
            questionUserInfo.topAnchor.constraint(equalTo: questionTitleView.bottomAnchor,constant: 20.0)
        ])
        NSLayoutConstraint.activate([
            likeButton.centerYAnchor.constraint(equalTo: questionUserInfo.centerYAnchor),
            likeButton.trailingAnchor.constraint(equalTo:  self.safeAreaLayoutGuide.trailingAnchor,constant: -20.0)
        ])
       NSLayoutConstraint.activate([
            questionContentView.leadingAnchor.constraint(equalTo: questionTitleView.leadingAnchor),
            questionContentView.trailingAnchor.constraint(equalTo: questionTitleView.trailingAnchor),
            questionContentView.topAnchor.constraint(equalTo: likeButton.bottomAnchor,constant: 5.0)
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
          answerButton.topAnchor.constraint(equalTo: questionTimeView.bottomAnchor,constant: 10.0),
           answerButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
          answerButton.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant:-20.0),
          answerButton.widthAnchor.constraint(equalToConstant: 100)
        ])
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
}
class AnswerTableCell:UITableViewCell{
    static let ID = "AnswerTableCell"
    
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
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setLayout(){
        profile = AnswerProfileView()
        
        answerContentView = UILabel()
        answerContentView.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        answerContentView.font = answerContentView.font.withSize(20)
        answerContentView.numberOfLines = 0
        answerContentView.lineBreakMode = .byCharWrapping
        
        answerTimeView = UILabel()
        answerTimeView.text = "1분 전"
        
        answerPicture = UIImageView(image: UIColor.green.image(CGSize(width: 60, height: 40)))
        answerPicture.contentMode = .scaleAspectFit
        
        answerImages = [UIColor.yellow.image(CGSize(width: 100, height: 100)),UIColor.orange.image(CGSize(width: 100, height: 100)),UIColor.blue.image(CGSize(width: 1200, height: 800))]
        imageStackView = UIStackView()
        imageStackView.axis = .vertical
        imageStackView.distribution = .equalSpacing
        imageStackView.alignment = .leading
        imageStackView.spacing = 20
        for image in answerImages{
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageStackView.addArrangedSubview(imageView)
            NSLayoutConstraint.activate([
                imageView.widthAnchor.constraint(lessThanOrEqualTo:imageStackView.widthAnchor),
                imageView.widthAnchor.constraint(equalTo:imageView.heightAnchor,multiplier: image.size.width/image.size.height)
            ])
        }
        
        likeButton = UIButton()
        likeButton.setTitle("2", for: .normal)
        likeButton.setTitleColor(.black, for: .normal)
        likeButton.setImage(UIImage(systemName: "hand.thumbsup")?.withTintColor(.black,renderingMode: .alwaysOriginal),for:.normal)
        likeButton.contentHorizontalAlignment = .fill
        likeButton.contentVerticalAlignment = .fill
        likeButton.imageView?.contentMode = .scaleAspectFit
        dislikeButton = UIButton()
        dislikeButton.setTitle("3", for: .normal)
        dislikeButton.setImage(UIImage(systemName: "hand.thumbsdown")?.withTintColor(.black,renderingMode: .alwaysOriginal),for:.normal)
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
        
        profile.translatesAutoresizingMaskIntoConstraints = false
        answerContentView.translatesAutoresizingMaskIntoConstraints = false
        answerTimeView.translatesAutoresizingMaskIntoConstraints = false
        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        answerEditButton.translatesAutoresizingMaskIntoConstraints = false
        answerDeleteButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        dislikeButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(profile)
        contentView.addSubview(answerContentView)
        contentView.addSubview(answerTimeView)
        contentView.addSubview(imageStackView)
        contentView.addSubview(answerEditButton)
        contentView.addSubview(answerDeleteButton)
        contentView.addSubview(likeButton)
        contentView.addSubview(dislikeButton)
    }
    func setConstraints(){
        NSLayoutConstraint.activate([
            profile.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5.0),
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
            answerTimeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5.0),
            answerTimeView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5.0)
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
}
class QuestionDetailViewController:UIViewController{
    
    var answerTableView:UITableView!
    var questionView:QuestionView!
    var headerView : UITableViewHeaderFooterView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .white
        setLayout()
        setConstraint()
        // Do any additional setup after loading the view.
        
    }
    func setLayout(){
   
        navigationController?.isNavigationBarHidden = false
        
        
        answerTableView = UITableView(frame: .zero, style: .grouped)
        answerTableView.delegate = self
        answerTableView.dataSource = self
        answerTableView.register(AnswerTableCell.self, forCellReuseIdentifier: AnswerTableCell.ID)
        answerTableView.backgroundColor = .white
        answerTableView.sectionHeaderHeight = UITableView.automaticDimension
        answerTableView.separatorStyle = .none
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
extension QuestionDetailViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let questionView = QuestionView()
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AnswerTableCell.ID, for: indexPath)
        return cell
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
