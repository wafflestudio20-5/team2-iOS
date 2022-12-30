//
//  MyViewController.swift
//  jisikin-ios
//
//  Created by 김령교 on 2022/12/27.
//

import UIKit

//class KakaoButton: UIButton {
//    let pointSize: CGFloat = 13
//    let imagePadding: CGFloat = 15
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        tintColor = .white
//
//        let imageConfig = UIImage.SymbolConfiguration(pointSize: pointSize)
//        // imageSize == fontSize 일때 가능
//        guard let image = self.imageView?.image else { return }
//        guard let titleLabel = self.titleLabel else { return }
//        guard let titleText = titleLabel.text else { return }
//        let titleSize = titleText.size(withAttributes: [
//            NSAttributedString.Key.font: titleLabel.font as Any
//        ])
//        titleEdgeInsets = UIEdgeInsets(top: imagePadding, left: -image.size.width, bottom: -image.size.height, right: 0)
//        imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + imagePadding), left: 0, bottom: 0, right: -titleSize.width)
//
//        setPreferredSymbolConfiguration(imageConfig, forImageIn: .normal)
//    }
//
//    override func setTitle(_ title: String?, for state: UIControl.State) {
//        super.setTitle(title, for: state)
//        guard let text = title else { return }
//        let attribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: pointSize)]
//        let attributedTitle = NSAttributedString(string: text, attributes: attribute)
//        self.setAttributedTitle(attributedTitle, for: .normal)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}

class MyViewController: UIViewController {
    
    let profilePhotoView = UIImageView()
    let modifyProfileBtn = UIButton()
    let nickName = UILabel()
    
    let QABtn = UIButton()
    let heartedQBtn = UIButton()
    let logOutBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let profilePhotoSize = CGFloat(45)
        profilePhotoView.image = UIImage(systemName: "person.fill")
        profilePhotoView.layer.cornerRadius = profilePhotoSize
        profilePhotoView.clipsToBounds = true
        profilePhotoView.layer.borderWidth = 3.0
        profilePhotoView.layer.borderColor = UIColor.black.cgColor
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapModifyProfileBtn))
        profilePhotoView.addGestureRecognizer(tapGesture)
        profilePhotoView.isUserInteractionEnabled = true
        
        
        let smallConfig = UIImage.SymbolConfiguration(pointSize: 23, weight: .regular, scale: .large)
        
        modifyProfileBtn.setImage(UIImage(systemName:"pencil.circle.fill", withConfiguration: smallConfig)!.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        modifyProfileBtn.addTarget(self, action: #selector(onTapModifyProfileBtn), for: .touchUpInside)
        
        nickName.text = "닉네임"
        nickName.font = .systemFont(ofSize: 30)
        nickName.textColor = .black
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular, scale: .large)
        
        QABtn.configuration = .plain()
        QABtn.configuration?.imagePlacement = .top
        QABtn.configuration?.imagePadding = 10
        
        QABtn.setImage(UIImage(systemName:"checkmark.circle", withConfiguration: largeConfig)!.withTintColor(.systemGreen, renderingMode: .alwaysOriginal), for: .normal)
        QABtn.setTitle("나의 Q&A", for: .normal)
        QABtn.setTitleColor(.black, for: .normal)
        QABtn.setTitleColor(.black, for: .highlighted)
        QABtn.addTarget(self, action: #selector(onTapQABtn), for: .touchUpInside)
        
        
        heartedQBtn.configuration = .plain()
        heartedQBtn.configuration?.imagePlacement = .top
        heartedQBtn.configuration?.imagePadding = 10
        
        heartedQBtn.setImage(UIImage(systemName:"heart.text.square", withConfiguration: largeConfig)!.withTintColor(.systemRed, renderingMode: .alwaysOriginal), for: .normal)
        heartedQBtn.setTitle("좋아요 누른 질문", for: .normal)
        heartedQBtn.setTitleColor(.black, for: .normal)
        heartedQBtn.setTitleColor(.black, for: .highlighted)
        heartedQBtn.addTarget(self, action: #selector(onTapHeartedQBtn), for: .touchUpInside)
        
        
        logOutBtn.configuration = .plain()
        logOutBtn.configuration?.imagePlacement = .top
        logOutBtn.configuration?.imagePadding = 10
        
        logOutBtn.setImage(UIImage(systemName:"rectangle.portrait.and.arrow.right", withConfiguration: largeConfig)!.withTintColor(.darkText, renderingMode: .alwaysOriginal), for: .normal)
        logOutBtn.setTitle("로그아웃", for: .normal)
        logOutBtn.setTitleColor(.black, for: .normal)
        logOutBtn.setTitleColor(.black, for: .highlighted)
        logOutBtn.addTarget(self, action: #selector(onTapLogOutBtn), for: .touchUpInside)
        
//        profileBtn.configuration = .plain()
//        profileBtn.configuration?.imagePlacement = .top
//        profileBtn.configuration?.imagePadding = 10
//
//        profileBtn.setImage(UIImage(systemName:"pencil", withConfiguration: largeConfig)!.withTintColor(.darkText, renderingMode: .alwaysOriginal), for: .normal)
//        profileBtn.setTitle("프로필 수정", for: .normal)
//        profileBtn.setTitleColor(.black, for: .normal)
//        profileBtn.setTitleColor(.black, for: .highlighted)
//        profileBtn.addTarget(self, action: #selector(onTapProfileBtn), for: .touchUpInside)
        
        
        
        
        
//        logOutBtn.configuration = .plain()
//
//        var configuration = UIButton.Configuration.plain()
//        var titleContainer = AttributeContainer()
//        titleContainer.font = UIFont.boldSystemFont(ofSize: 20)
//        titleContainer.foregroundColor = .black
//        configuration.attributedTitle = AttributedString("로그아웃", attributes: titleContainer)
//
//        logOutBtn.configuration = configuration
//        logOutBtn.addTarget(self, action: #selector(onTapLogOutBtn), for: .touchUpInside)

        
//        var configuration = UIButton.Configuration.plain()
//
//        var titleContainer = AttributeContainer()
//        titleContainer.font = UIFont.boldSystemFont(ofSize: 20)
//
//        var subtitleContainer = AttributeContainer()
//        subtitleContainer.foregroundColor = UIColor.white.withAlphaComponent(0.5)
//
//        // 버튼 Contents 커스텀
//        configuration.attributedTitle = AttributedString("Title", attributes: titleContainer)
//        configuration.attributedSubtitle = AttributedString("Subtitle", attributes: subtitleContainer)
//        configuration.image = UIImage(systemName: "swift")
//        configuration.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 30)
//        configuration.imagePadding = 10
//
//        // 이미지가 왼쪽에 위치한 버튼
//        configuration.titleAlignment = .leading
//        let leftButton = UIButton(configuration: configuration)
//
//        // 이미지가 상단에 위치한 버튼
//        configuration.imagePlacement = .top
//        let topButton = UIButton(configuration: configuration)
//
//        // 이미지가 오른쪽에 위치한 버튼
//        configuration.imagePlacement = .trailing
//        let rightButton = UIButton(configuration: configuration)
//
//        // 이미지가 하단에 위치한 버튼
//        configuration.imagePlacement = .bottom
//        let bottomButton = UIButton(configuration: configuration)
        
        view.addSubview(profilePhotoView)
        view.addSubview(modifyProfileBtn)
        view.addSubview(nickName)
        view.addSubview(QABtn)
//        view.addSubview(profileBtn)
        view.addSubview(heartedQBtn)
        view.addSubview(logOutBtn)
//        view.addSubview(leftButton)
        profilePhotoView.translatesAutoresizingMaskIntoConstraints = false
        modifyProfileBtn.translatesAutoresizingMaskIntoConstraints = false
        nickName.translatesAutoresizingMaskIntoConstraints = false
        QABtn.translatesAutoresizingMaskIntoConstraints = false
        heartedQBtn.translatesAutoresizingMaskIntoConstraints = false
        logOutBtn.translatesAutoresizingMaskIntoConstraints = false
//        leftButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profilePhotoView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            profilePhotoView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: -profilePhotoSize),
            profilePhotoView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: profilePhotoSize),
            profilePhotoView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20-profilePhotoSize),//20
            profilePhotoView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20+profilePhotoSize),//20
            modifyProfileBtn.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor,constant: profilePhotoSize/1.414),
            modifyProfileBtn.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20+profilePhotoSize/1.414),//20
            nickName.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            nickName.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 90),
            QABtn.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: -120),
            QABtn.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 180),//180
            heartedQBtn.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            heartedQBtn.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 180),//180
            logOutBtn.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: 120),
            logOutBtn.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 180),//180
        ])
        // Do any additional setup after loading the view.
    }
    @objc
    func onTapModifyProfileBtn() {
        let vc = ModifyProfileViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc
    func onTapQABtn() {
        let vc = MyQAViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    func onTapHeartedQBtn() {
        let vc = HeartedQViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @objc
    func onTapLogOutBtn() {
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//extension UIButton {
//    func alignTextBelow(spacing: CGFloat = 4.0) {
//            guard let image = self.imageView?.image else {
//                return
//            }
//
//            guard let titleLabel = self.titleLabel else {
//                return
//            }
//
//            guard let titleText = titleLabel.text else {
//                return
//            }
//
//            let titleSize = titleText.size(withAttributes: [
//                NSAttributedString.Key.font: titleLabel.font as Any
//            ])
//
//            titleEdgeInsets = UIEdgeInsets(top: spacing, left: -image.size.width, bottom: -image.size.height, right: 0)
//            imageEdgeInsets = UIEdgeInsets(top: -(titleSize.height + spacing), left: 0, bottom: 0, right: -titleSize.width)
//        }
//}
