//
//  DevViewController.swift
//  jisikin-ios
//
//  Created by Chaehyun Park on 2023/01/28.
//

import UIKit
import SafariServices

class DevView: UIView {
    
    let hideInstaButton: Bool

    required init(hideInstaButton: Bool){
        self.hideInstaButton = hideInstaButton
        super.init(frame: CGRect.zero)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 60, height: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "이름"
        label.font = UIFont(name: "NanumSquareNeoTTF-cBd", size: 20)
        label.textColor = .black
        return label
    }()
    
    let positionLabel:UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 60, height: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "직함"
        label.font = UIFont(name: "NanumSquareNeoTTF-cBd", size: 15)
        label.textColor = .black
        return label
    }()
    
    let introLabel:UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 60, height: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "자기소개"
        label.font = UIFont(name: "NanumSquareNeoTTF-bRg", size: 12)
        label.textColor = .black
        return label
    }()

    let githubButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "GithubLogo"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        
        return button
    }()

    let instaButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "InstaLogo"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentMode = .scaleAspectFit
        button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        return button
    }()
    
    private func commonInit(){
        self.backgroundColor = UIColor(displayP3Red: 248/255, green: 245/255, blue: 241/255, alpha: 1)
        
        self.addSubview(nameLabel)
        self.addSubview(positionLabel)
        self.addSubview(introLabel)
        self.addSubview(instaButton)
        self.addSubview(githubButton)
        
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        
        constraintCustomView()
    }
    
    func constraintCustomView() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            positionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            positionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            introLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            introLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            introLabel.topAnchor.constraint(equalTo: positionLabel.bottomAnchor, constant: 10)
        ])
        
        if(hideInstaButton == true){
            NSLayoutConstraint.activate([
                githubButton.leadingAnchor.constraint(equalTo: self.trailingAnchor, constant: -35),
                githubButton.trailingAnchor.constraint(equalTo: githubButton.leadingAnchor, constant: 25),
                githubButton.topAnchor.constraint(equalTo: githubButton.bottomAnchor, constant: -25),
                githubButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
            ])
        }
        
        else{
            NSLayoutConstraint.activate([
                githubButton.leadingAnchor.constraint(equalTo: self.trailingAnchor, constant: -65),
                githubButton.trailingAnchor.constraint(equalTo: githubButton.leadingAnchor, constant: 25),
                githubButton.topAnchor.constraint(equalTo: githubButton.bottomAnchor, constant: -25),
                githubButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
            ])
            
            NSLayoutConstraint.activate([
                instaButton.leadingAnchor.constraint(equalTo: githubButton.trailingAnchor, constant: 5),
                instaButton.trailingAnchor.constraint(equalTo: instaButton.leadingAnchor, constant: 25),
                instaButton.topAnchor.constraint(equalTo: instaButton.bottomAnchor, constant: -25),
                instaButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
            ])
        }
    }
    
    override var intrinsicContentSize: CGSize {
        //preferred content size, calculate it if some internal state changes
        return CGSize(width: 300, height: 150)
    }
    
}

class DevViewController: UIViewController {
    
    var scrollView = UIScrollView()
    var logoImageView = UIImageView()
    var titleLabel = UILabel()
    var subtitleLabel = UILabel()
    var devViews = [DevView(hideInstaButton: false), DevView(hideInstaButton: false), DevView(hideInstaButton: true), DevView(hideInstaButton: false), DevView(hideInstaButton: false), DevView(hideInstaButton: false), DevView(hideInstaButton: false)]
    
    private let verticalStackView: UIStackView = {
        let view: UIStackView = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.spacing = 20
        view.alignment = .center
        return view
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        setDesign()
        setView()
        setConstraint()
        
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    
        scrollView.contentInset = insets
    }
    
    func setDesign() {
        view.backgroundColor = .white

        navigationController?.isNavigationBarHidden = false
        
        logoImageView = UIImageView(image: UIImage(named: "AppLogo"))
        logoImageView.contentMode = .scaleAspectFit
        
        titleLabel.text = "지식2n을 만든 개발자들"
        titleLabel.font = UIFont(name: "NanumSquareNeoTTF-eHv", size: 30)
        
        subtitleLabel.text = "Team2의 팀원을 소개합니다."
        subtitleLabel.font = UIFont(name: "NanumSquareNeoTTF-bRg", size: 20)
        subtitleLabel.textColor = UIColor.gray
        
        devViews[0].nameLabel.text = "조성규"
        devViews[0].positionLabel.text = "Spring Developer"
        devViews[0].introLabel.text = "보람차고 뜻깊은 시간이었습니다. 팀원들이 없었다면 여기까지 오지 못했을 겁니다. 부족한 PO를 믿고 따라와줘서 감사합니다. 모두 고생했고, 앞으로도 잘 부탁드려요~"
        devViews[0].introLabel.numberOfLines = 0
        devViews[0].introLabel.setLineSpacing(spacing: 3)
        
        devViews[1].nameLabel.text = "김령교"
        devViews[1].positionLabel.text = "iOS Developer"
        devViews[1].introLabel.text = "서울대학교 컴퓨터공학부 22학번 김령교입니다"
        devViews[1].introLabel.numberOfLines = 0
        
        devViews[2].nameLabel.text = "박정헌"
        devViews[2].positionLabel.text = "iOS Developer"
        devViews[2].introLabel.text = "안녕하세요. ios 개발자 박정헌입니다."
        devViews[2].introLabel.numberOfLines = 0
        devViews[2].instaButton.removeFromSuperview()
        
        devViews[3].nameLabel.text = "박채현"
        devViews[3].positionLabel.text = "iOS Developer"
        devViews[3].introLabel.text = "컴퓨터공학부 22학번 / 영화를 좋아합니다"
        devViews[3].introLabel.numberOfLines = 0
        
        devViews[4].nameLabel.text = "우혁준"
        devViews[4].positionLabel.text = "Spring Developer"
        devViews[4].introLabel.text = "난 아직 배가 고프다"
        devViews[4].introLabel.numberOfLines = 0
        
        devViews[5].nameLabel.text = "이지원"
        devViews[5].positionLabel.text = "Spring Developer"
        devViews[5].introLabel.text = "귀여운 동물을 좋아하는 개발자 입니다."
        devViews[5].introLabel.numberOfLines = 0
        
        devViews[6].nameLabel.text = "홍희주"
        devViews[6].positionLabel.text = "iOS Developer"
        devViews[6].introLabel.text = "서울대 에너지자원공학과 21학번"
        devViews[6].introLabel.numberOfLines = 0
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        for i in 0..<7{
            devViews[i].translatesAutoresizingMaskIntoConstraints = false
        }
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        for i in 0..<7{
            devViews[i].githubButton.tag = i
            devViews[i].githubButton.addTarget(self, action: #selector(tapGithubButton), for: .touchUpInside)
            
            devViews[i].instaButton.addTarget(self, action: #selector(tapInstaButton), for: .touchUpInside)
            devViews[i].instaButton.tag = i

        }
    }
    
    func setView() {
        view.addSubview(scrollView)
        scrollView.addSubview(logoImageView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(subtitleLabel)
        scrollView.addSubview(verticalStackView)
        for i in 0..<7{
            verticalStackView.addArrangedSubview(devViews[i])
        }
    }
    
    func setConstraint() {

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            logoImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            logoImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            logoImageView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            logoImageView.bottomAnchor.constraint(equalTo: logoImageView.topAnchor, constant: 230)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
        ])
        
        NSLayoutConstraint.activate([
            verticalStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 30),
            verticalStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -30),
            verticalStackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            verticalStackView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 20),
            verticalStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        for i in 0..<7{
            NSLayoutConstraint.activate([
                    devViews[i].leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor),
                    devViews[i].trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor)
            ])
        }
    }
    
    @objc func tapGithubButton(sender: UIButton) {
        var url : URL!

        switch sender.tag{
        case 0:
            url = URL(string: "https://github.com/skfotakf")
        case 1:
            url = URL(string: "https://github.com/lumirevel")
        case 2:
            url = URL(string: "https://github.com/impri2")
        case 3:
            url = URL(string: "https://github.com/parkchaehyun")
        case 4:
            url = URL(string: "https://github.com/huGgW")
        case 5:
            url = URL(string: "https://github.com/jiwon79")
        case 6:
            url = URL(string: "https://github.com/jeenakit")
        default:
            break
        }
        
        self.present(SFSafariViewController(url: url), animated: true, completion: nil)
    }
    
    @objc func tapInstaButton(sender: UIButton) {
        var username : String
        switch sender.tag{
        case 0:
            username = "26___gyu"
        case 1:
            username = "lumirevel"
        case 2:
            username = ""
        case 3:
            username = "park_chaehyun"
        case 4:
            username = "whjoon0225"
        case 5:
            username = "easy_sleepy"
        case 6:
            username = "cxerrxxieceontox"
        default:
            username = ""
        }
        
        let appURL = URL(string: "instagram://user?username=\(username)")!
        let webURL = URL(string: "https://instagram.com/\(username)")!
        
        if UIApplication.shared.canOpenURL(appURL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appURL, options: [:], completionHandler: nil)
            }
            
            else {
                UIApplication.shared.openURL(appURL)
            }
        }
        else {
              // redirect to safari because the user doesn't have Instagram
            self.present(SFSafariViewController(url: webURL), animated: true, completion: nil)

            /*if #available(iOS 10.0, *) {
                UIApplication.shared.open(webURL, options: [:], completionHandler: nil)
            }
            else {
                UIApplication.shared.openURL(webURL)
            }*/
        }
        
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
