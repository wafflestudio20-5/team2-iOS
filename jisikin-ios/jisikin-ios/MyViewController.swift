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

//UserDefaults.standard.setValue(try? PropertyListEncoder().encode(todos), forKey: "ToDos") //save code
/*if let data = UserDefaults.standard.data(forKey: "ToDos") {
todos = try! PropertyListDecoder().decode([ToDo].self, from: data)
}*///load code

//UserDefaults.standard.set(1, forKey: "isLogin")

class MyViewController: UIViewController {
    
    
    
    let profilePhotoView = UIImageView()
    let modifyProfileBtn = UIButton()
    let nickName = UILabel()
    
    let QABtn = UIButton()
    let heartedQBtn = UIButton()
    let logInOutBtn = UIButton()
    
    var viewModel = ProfileViewModel()
    
    let LoginRepo = LoginRepository()
    
    override func loadView(){
        super.loadView()
        let isLogin = UserDefaults.standard.bool(forKey: "isLogin")
        
        self.view.backgroundColor = .white
        
        if isLogin{
            viewModel.getProfile()
        }
        
        let profilePhotoSize = CGFloat(45)
        //profilePhotoView.image = UIImage(systemName: "person.fill")!.withTintColor(.white, renderingMode: .alwaysOriginal)
        
        profilePhotoView.backgroundColor = .black
        profilePhotoView.layer.cornerRadius = profilePhotoSize
        profilePhotoView.clipsToBounds = true
        profilePhotoView.layer.borderWidth = 3.0
        if isLogin{
            profilePhotoView.image = UIImage(named:"DefaultProfilePhoto")
            profilePhotoView.layer.borderColor = BLUE_COLOR.cgColor
        }else{
            profilePhotoView.image = UIImage(named:"DefaultProfilePhoto")
            profilePhotoView.layer.borderColor = .none
        }
        
        let tapGesture: UITapGestureRecognizer
        if isLogin{
            tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapModifyProfileBtn))
        }else{
            tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapLogInBtn))
        }
        profilePhotoView.addGestureRecognizer(tapGesture)
        profilePhotoView.isUserInteractionEnabled = true
        
        if isLogin{
            let smallConfig = UIImage.SymbolConfiguration(pointSize: 23, weight: .regular, scale: .large)
            
            modifyProfileBtn.setImage(UIImage(systemName:"pencil.circle.fill", withConfiguration: smallConfig)!.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
            modifyProfileBtn.addTarget(self, action: #selector(onTapModifyProfileBtn), for: .touchUpInside)
            modifyProfileBtn.isHidden = false
            modifyProfileBtn.isEnabled = true
        }else{
            modifyProfileBtn.removeTarget(nil, action: nil, for: .allEvents)
            modifyProfileBtn.isHidden = true
            modifyProfileBtn.isEnabled = false
        }
        
        
        if isLogin{
            nickName.text = UserDefaults.standard.string(forKey: "username")
        }else{
            nickName.text = "로그인해주세요"
        }
        
        nickName.font = .systemFont(ofSize: 30)
        nickName.textColor = .black
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular, scale: .large)
        
        QABtn.configuration = .plain()
        QABtn.configuration?.imagePlacement = .top
        QABtn.configuration?.imagePadding = 10
        QABtn.setImage(UIImage(systemName:"checkmark.circle", withConfiguration: largeConfig)!.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        QABtn.setTitle("나의 Q&A", for: .normal)
        QABtn.setTitleColor(.black, for: .normal)
        QABtn.setTitleColor(.black, for: .highlighted)
        if isLogin{
            QABtn.removeTarget(nil, action: nil, for: .allEvents)
            QABtn.addTarget(self, action: #selector(onTapQABtn), for: .touchUpInside)
        }else{
            QABtn.removeTarget(nil, action: nil, for: .allEvents)
            QABtn.addTarget(self, action: #selector(onTapLogInBtn), for: .touchUpInside)
        }
        
        
        
        heartedQBtn.configuration = .plain()
        heartedQBtn.configuration?.imagePlacement = .top
        heartedQBtn.configuration?.imagePadding = 10
        
        heartedQBtn.setImage(UIImage(systemName:"heart.text.square", withConfiguration: largeConfig)!.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        heartedQBtn.setTitle("좋아요 누른 질문", for: .normal)
        heartedQBtn.setTitleColor(.black, for: .normal)
        heartedQBtn.setTitleColor(.black, for: .highlighted)
        if isLogin{
            heartedQBtn.removeTarget(nil, action: nil, for: .allEvents)
            heartedQBtn.addTarget(self, action: #selector(onTapHeartedQBtn), for: .touchUpInside)
        }else{
            heartedQBtn.removeTarget(nil, action: nil, for: .allEvents)
            heartedQBtn.addTarget(self, action: #selector(onTapLogInBtn), for: .touchUpInside)
        }
        
        
        
        logInOutBtn.configuration = .plain()
        logInOutBtn.configuration?.imagePlacement = .top
        logInOutBtn.configuration?.imagePadding = 10
        
        logInOutBtn.setTitleColor(.black, for: .normal)
        logInOutBtn.setTitleColor(.black, for: .highlighted)
        if isLogin{
            logInOutBtn.setImage(UIImage(systemName:"rectangle.portrait.and.arrow.right", withConfiguration: largeConfig)!.withTintColor(.darkText, renderingMode: .alwaysOriginal), for: .normal)
            logInOutBtn.setTitle("로그아웃", for: .normal)
            logInOutBtn.removeTarget(nil, action: nil, for: .allEvents)
            logInOutBtn.addTarget(self, action: #selector(onTapLogOutBtn), for: .touchUpInside)
        }else{
            logInOutBtn.setImage(UIImage(systemName:"rectangle.portrait.and.arrow.right", withConfiguration: largeConfig)!.withTintColor(.darkText, renderingMode: .alwaysOriginal), for: .normal)
            logInOutBtn.setTitle("로그인", for: .normal)
            logInOutBtn.removeTarget(nil, action: nil, for: .allEvents)
            logInOutBtn.addTarget(self, action: #selector(onTapLogInBtn), for: .touchUpInside)
        }
        
        
        view.addSubview(profilePhotoView)
        view.addSubview(modifyProfileBtn)
        view.addSubview(nickName)
        view.addSubview(QABtn)
        view.addSubview(heartedQBtn)
        view.addSubview(logInOutBtn)
        profilePhotoView.translatesAutoresizingMaskIntoConstraints = false
        modifyProfileBtn.translatesAutoresizingMaskIntoConstraints = false
        nickName.translatesAutoresizingMaskIntoConstraints = false
        QABtn.translatesAutoresizingMaskIntoConstraints = false
        heartedQBtn.translatesAutoresizingMaskIntoConstraints = false
        logInOutBtn.translatesAutoresizingMaskIntoConstraints = false
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
            logInOutBtn.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: 120),
            logInOutBtn.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 180),//180
        ])
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setBackButton()
        // Do any additional setup after loading the view.
    }
    func setBackButton() {
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = UIColor(named: "MainColor")
        self.navigationItem.backBarButtonItem = backBarButtonItem
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
        
        LoginRepo.logout(completionHandler: { completionHandler in
            if(completionHandler == "success"){
                UserDefaults.standard.set(false, forKey: "isLogin")
            }
            
            else {
                let errorAlert = UIAlertController(title: nil, message: "로그아웃 실패", preferredStyle: .alert)
                let errorAction = UIAlertAction(title: "확인", style:UIAlertAction.Style.default)
                
                errorAlert.addAction(errorAction)
                
                self.present(errorAlert, animated: false)
            }
            
            self.loadView()
        })
    }
    @objc
    func onTapLogInBtn() {
        let vc = LoginViewController()
        self.navigationController?.pushViewController(vc, animated: true)
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
