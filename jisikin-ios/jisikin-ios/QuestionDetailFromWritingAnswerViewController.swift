//
//  QuestionDetailFromWritingAnswerViewController.swift
//  jisikin-ios
//
//  Created by Chaehyun Park on 2023/01/17.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class SimpleQuestionView:UIView {
    var tags:[String] = []

    var questionTitleView:UILabel!
    var questionUserInfo:UILabel!
    var questionContentView:UILabel!
    var questionTimeView:UILabel!
    var imageStackView:UIStackView!
    var questionImages:[UIImage] = []
    var tagView:SelfSizingCollectionView!
    var onImageLoaded:(()->())?
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
        questionContentView.text = ""
        questionContentView.numberOfLines = 0
        questionContentView.lineBreakMode = .byWordWrapping
        questionContentView.font = questionTitleView.font.withSize(20)
        
        questionTimeView = UILabel()
        questionTimeView.text = "2022.12.16"
        questionTimeView.textColor = .lightGray

        
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
        imageStackView.translatesAutoresizingMaskIntoConstraints = false
        questionTimeView.translatesAutoresizingMaskIntoConstraints = false
        tagView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(questionTitleView)
        addSubview(questionUserInfo)
        addSubview(questionContentView)
        addSubview(imageStackView)
        addSubview(questionTimeView)
        addSubview(tagView)
    }
    
    func setConstraint(){
        NSLayoutConstraint.activate([
            questionTitleView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,constant: 20),
            questionTitleView.leadingAnchor.constraint(equalTo:  self.leadingAnchor,constant: 20.0),
            questionTitleView.trailingAnchor.constraint(equalTo:  self.trailingAnchor,constant: -20.0)
        ])
        NSLayoutConstraint.activate([
            questionUserInfo.leadingAnchor.constraint(equalTo: questionTitleView.leadingAnchor),
            questionUserInfo.topAnchor.constraint(equalTo: questionTitleView.bottomAnchor,constant: 10.0)
        ])
       NSLayoutConstraint.activate([
            questionContentView.leadingAnchor.constraint(equalTo: questionTitleView.leadingAnchor),
            questionContentView.trailingAnchor.constraint(equalTo: questionTitleView.trailingAnchor),
            questionContentView.topAnchor.constraint(equalTo: questionUserInfo.bottomAnchor,constant: 20.0)
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
            tagView.topAnchor.constraint(equalTo: questionTimeView.bottomAnchor,constant: 5.0),
            tagView.leadingAnchor.constraint(equalTo: questionTitleView.leadingAnchor),
            tagView.trailingAnchor.constraint(equalTo: questionTitleView.trailingAnchor),
        ])
    }
    func configure(question:QuestionDetailModel){
        questionTitleView.text = question.title
        questionTimeView.text = question.createdAt
        questionContentView.text = question.content
        questionUserInfo.text = question.username
        
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
        
        tags = question.tag
        tagView.reloadData()
    }
}

extension SimpleQuestionView:UICollectionViewDataSource{
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
extension SimpleQuestionView:UICollectionViewDelegate{
    
}
extension SimpleQuestionView:UICollectionViewDelegateFlowLayout{
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

class QuestionDetailFromWritingAnswerViewController:UIViewController{
    var bag = DisposeBag()
    var questionView = SimpleQuestionView()
    var scrollView : UIScrollView! = UIScrollView()
    var viewModel:QuestionDetailViewModel
    init(viewModel:QuestionDetailViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        viewModel.refresh()
        setLayout()
        setConstraint()
        
        viewModel.question.subscribe(onNext: {[weak self]
            question in
            if self==nil{return}
            if let question{
                self!.questionView.configure(question:question)
            }
            self?.scrollView.updateContentSize()
        }).disposed(by: bag)
        
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0)
    
        scrollView.contentInset = insets
        scrollView.scrollIndicatorInsets = insets
    }

    func setLayout(){
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        questionView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(questionView)
        view.addSubview(scrollView)
    }
    
    func setConstraint(){
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            questionView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            questionView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            questionView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            questionView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
        ])
    }
}
