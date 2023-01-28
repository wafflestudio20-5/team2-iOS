import Foundation
import UIKit
import RxSwift
import RxCocoa
import Kingfisher
class QuestionLikeView:UIView{
    var likeButton:UIButton!
    var likeNumber:UILabel!
    var onLike:(()->())?
    var selectedImage:UIImage = UIImage(systemName: "heart.fill")!.withTintColor(.red,renderingMode:.alwaysOriginal)
    var unSelectedImage:UIImage = UIImage(systemName: "heart")!.withTintColor(.black)
    override init(frame:CGRect){
        super.init(frame:frame)
        setLayout()
        setConstraint()
        layer.borderColor =  CGColor(gray: 225/255, alpha: 1)
        layer.borderWidth = 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setLayout(){
      
      
        
        likeButton = UIButton()
        likeButton.setImage(systemName: "heart", color: .black)
        likeButton.contentMode = .center
        likeButton.imageView?.contentMode = .scaleAspectFit
        likeButton.addTarget( self, action:#selector(onLikeButtonClicked),for:.touchDown)
        likeNumber = UILabel()
        likeNumber.text = "10"
        likeNumber.font = likeNumber.font.withSize(23)
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeNumber.translatesAutoresizingMaskIntoConstraints = false
        addSubview(likeButton)
        addSubview(likeNumber)
    }
    func setConstraint(){
        NSLayoutConstraint.activate([
            likeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant:15.0),
            likeButton.heightAnchor.constraint(equalTo: likeButton.widthAnchor),
            likeNumber.leadingAnchor.constraint(equalTo: likeButton.trailingAnchor,constant:5.0),
            trailingAnchor.constraint(equalTo: likeButton.trailingAnchor,constant:50.0),
            likeButton.topAnchor.constraint(equalTo: likeNumber.topAnchor),
            likeNumber.topAnchor.constraint(equalTo: topAnchor,constant:10.0),
            likeNumber.bottomAnchor.constraint(equalTo: bottomAnchor,constant:-10.0),
            likeButton.heightAnchor.constraint(equalTo: likeNumber.heightAnchor)
        ])
    }
    @objc func onLikeButtonClicked(){
            onLike?()
        }
    func configure(isLike:Bool,likeCount:Int){
      
        likeNumber.text = String(likeCount)
        if isLike{
            likeButton.setImage(selectedImage,for:.normal)
        }
        else{
            likeButton.setImage(unSelectedImage,for:.normal)
        }
    }
    
    
}
class QuestionView:UIView{
    var likeNumber = 0
    var liked = false
    
    var tags:[String] = []
    var lineOnTop:UIView!
    var questionTitleView:UILabel!
    var questionUserInfo:UILabel!
    var questionContentView:UILabel!
    var questionTimeView:UILabel!
    var questionEditButton:UIButton!
    var questionDeleteButton:UIButton!
    
   
    var answerButton:UIButton!
    var imageStackView:UIStackView!
    var tagView:SelfSizingCollectionView!
    var questionImages:[UIImage] = []
    var onAnswerButtonClicked:(()->())?
    var onImageLoaded:(()->())?
    var onDeleteButtonClicked:(()->())?
    var onLikeButtonClicked:(()->())?
    var likeView:QuestionLikeView!
    override init(frame:CGRect){
        super.init(frame:frame)
        setLayout()
        setConstraint()
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setLayout(){
        
        lineOnTop = UIView()
        lineOnTop.backgroundColor = .init(red: 229/255, green: 229/255, blue: 229/255, alpha: 1)
        
        questionTitleView = UILabel()
        questionTitleView.font = questionTitleView.font.withSize(27)
        questionTitleView.textColor = .black
        questionTitleView.numberOfLines = 0
       
     
        questionUserInfo = UILabel()
        questionUserInfo.textColor = .init(red: 155/255, green: 155/255, blue: 155/255, alpha: 1)
        questionUserInfo.font = questionUserInfo.font.withSize(15)
        
        questionContentView = UILabel()
        questionContentView.numberOfLines = 0
        questionContentView.lineBreakMode = .byCharWrapping
        questionContentView.font = questionTitleView.font.withSize(20)
        
     
        questionTimeView = UILabel()
        questionTimeView.textColor = .lightGray
        questionEditButton = UIButton()
        questionEditButton.setTitle("수정", for: .normal)
        questionEditButton.setTitleColor(.gray, for: .normal)
        questionTimeView.font = questionTimeView.font.withSize(15)
        
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
        
        likeView = QuestionLikeView()
       
        
        lineOnTop.translatesAutoresizingMaskIntoConstraints = false
        questionTitleView.translatesAutoresizingMaskIntoConstraints = false
        questionUserInfo.translatesAutoresizingMaskIntoConstraints = false
        questionContentView.translatesAutoresizingMaskIntoConstraints = false
     
        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        questionTimeView.translatesAutoresizingMaskIntoConstraints = false
        questionEditButton.translatesAutoresizingMaskIntoConstraints = false
        questionDeleteButton.translatesAutoresizingMaskIntoConstraints = false
        answerButton.translatesAutoresizingMaskIntoConstraints = false
        
        tagView.translatesAutoresizingMaskIntoConstraints = false
        likeView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lineOnTop)
        addSubview(questionTitleView)
        addSubview(questionUserInfo)
        addSubview(questionContentView)
     
        addSubview(imageStackView)
        addSubview(questionTimeView)
        addSubview(questionEditButton)
        addSubview(questionDeleteButton)
        addSubview(answerButton)
        addSubview(tagView)
        addSubview(likeView)
    }
    
    func setConstraint(){
        NSLayoutConstraint.activate([
            lineOnTop.topAnchor.constraint(equalTo: self.topAnchor,constant:10.0),
            lineOnTop.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            lineOnTop.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            lineOnTop.heightAnchor.constraint(equalToConstant: 2.0)
        ])
        NSLayoutConstraint.activate([
            questionTitleView.topAnchor.constraint(equalTo: self.lineOnTop.bottomAnchor,constant: 20.0),
            questionTitleView.leadingAnchor.constraint(equalTo:  self.leadingAnchor,constant: 20.0),
            questionTitleView.trailingAnchor.constraint(equalTo:  self.trailingAnchor,constant: -20.0)
        ])
        NSLayoutConstraint.activate([
            questionUserInfo.leadingAnchor.constraint(equalTo: questionTitleView.leadingAnchor),
            questionUserInfo.topAnchor.constraint(equalTo: questionTitleView.bottomAnchor,constant: 5.0)
        ])

    
       NSLayoutConstraint.activate([
            questionContentView.leadingAnchor.constraint(equalTo: questionTitleView.leadingAnchor),
            questionContentView.trailingAnchor.constraint(equalTo: questionTitleView.trailingAnchor),
            questionContentView.topAnchor.constraint(equalTo:questionUserInfo.bottomAnchor,constant: 10.0)
        ])
        NSLayoutConstraint.activate([
            imageStackView.leadingAnchor.constraint(equalTo: questionTitleView.leadingAnchor),
            imageStackView.trailingAnchor.constraint(equalTo: questionTitleView.trailingAnchor),
            imageStackView.topAnchor.constraint(equalTo: questionContentView.bottomAnchor,constant: 5.0)
        ])
        NSLayoutConstraint.activate([
            questionTimeView.leadingAnchor.constraint(equalTo: questionTitleView.leadingAnchor),
            questionTimeView.topAnchor.constraint(equalTo: imageStackView.bottomAnchor,constant: 10.0),
          
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
            tagView.topAnchor.constraint(equalTo: questionTimeView.bottomAnchor,constant: 20.0),
            tagView.leadingAnchor.constraint(equalTo: questionTitleView.leadingAnchor),
            tagView.trailingAnchor.constraint(equalTo: questionTitleView.trailingAnchor),
       
        ])
        NSLayoutConstraint.activate([
            likeView.topAnchor.constraint(equalTo: tagView.bottomAnchor,constant:30.0),
            likeView.leadingAnchor.constraint(equalTo: questionTitleView.leadingAnchor)
        ])
    
        NSLayoutConstraint.activate([
          answerButton.topAnchor.constraint(equalTo: likeView.bottomAnchor,constant: 15.0),
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
    func setOnLikeButtonClicked(on:@escaping()->()){
        likeView.onLike = on
    }
    func configure(question:QuestionDetailModel,hasAnswers:Bool){
        liked = question.liked
        likeNumber = question.likeNumber
        likeView.configure(isLike: question.liked, likeCount: question.likeNumber)
        questionTitleView.text = question.title
        questionTimeView.text = question.createdAt
        questionContentView.text = question.content
        questionContentView.setLineSpacing(spacing: 4.0)
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
    
        imageStackView.safelyRemoveArrangedSubviews()
        for image in question.photos{
            let imageView = UIImageView()
           
            imageStackView.addArrangedSubview(imageView)
            imageView.kf.setImage(with:URL(string:image)!){ [self]result in
                if case .success = result{
                    imageView.contentMode = .scaleAspectFit
                    
                    NSLayoutConstraint.activate([
                        imageView.widthAnchor.constraint(lessThanOrEqualToConstant: imageStackView.frame.width),
                        imageView.widthAnchor.constraint(equalTo:imageView.heightAnchor,multiplier: imageView.image!.size.width/imageView.image!.size.height)
                    ])
                    onImageLoaded?()
                    layoutIfNeeded()
                }
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
       
        //setLikeButton(like: question.liked)
    }
    func likeButtonPressed(){
        if liked{
            liked = false
            likeNumber -= 1
        }
        else{
            liked = true
            likeNumber += 1
        }
        likeView.configure(isLike: liked, likeCount: likeNumber)
    }
    
}
extension QuestionView:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      
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
          
            return CGSize(width: cellWidth, height: 22)
        
        
    }
}
extension UILabel {
    func setLineSpacing(spacing: CGFloat) {
        guard let text = text else { return }

        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = spacing
        attributeString.addAttribute(.paragraphStyle,
                                     value: style,
                                     range: NSRange(location: 0, length: attributeString.length))
        attributedText = attributeString
    }
}
