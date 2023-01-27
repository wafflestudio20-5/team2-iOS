//
//  MyViewController.swift
//  jisikin-ios
//
//  Created by 김령교 on 2022/12/27.
//

import UIKit
import RxSwift

//UserDefaults.standard.setValue(try? PropertyListEncoder().encode(todos), forKey: "ToDos") //save code
/*if let data = UserDefaults.standard.data(forKey: "ToDos") {
todos = try! PropertyListDecoder().decode([ToDo].self, from: data)
}*///load code

//UserDefaults.standard.set(1, forKey: "isLogin")

class MyViewController: UIViewController {
    let bag = DisposeBag()
    
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
        
        let profilePhotoSize = CGFloat(45)
        
        profilePhotoView.backgroundColor = .black
        profilePhotoView.layer.cornerRadius = profilePhotoSize
        profilePhotoView.clipsToBounds = true
        profilePhotoView.layer.borderWidth = 3.0
        
        
        let tapGesture: UITapGestureRecognizer
        
        
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
        
        
        heartedQBtn.configuration = .plain()
        heartedQBtn.configuration?.imagePlacement = .top
        heartedQBtn.configuration?.imagePadding = 10
        
        heartedQBtn.setImage(UIImage(systemName:"heart.text.square", withConfiguration: largeConfig)!.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        heartedQBtn.setTitle("좋아요 누른 질문", for: .normal)
        heartedQBtn.setTitleColor(.black, for: .normal)
        heartedQBtn.setTitleColor(.black, for: .highlighted)
        
        
        logInOutBtn.configuration = .plain()
        logInOutBtn.configuration?.imagePlacement = .top
        logInOutBtn.configuration?.imagePadding = 10
        
        logInOutBtn.setTitleColor(.black, for: .normal)
        logInOutBtn.setTitleColor(.black, for: .highlighted)
        
        
        if isLogin{
            viewModel.getProfile()
            viewModel.profile.subscribe(onNext: {[weak self]
                profile in
                if self==nil{return}
                if let profile{
                    
                    profile.profileImage.subscribe(onNext:{[weak self] image in
                        if let profileImage = image{
                            if UserDefaults.standard.bool(forKey: "isLogin"){
                                print("profile image updated in VC")
                                self!.profilePhotoView.image = profileImage
                            }
                            
                        }
                        else{
                            if UserDefaults.standard.bool(forKey: "isLogin"){
                                if let data = UserDefaults.standard.data(forKey: "profileImage"){
                                    self!.profilePhotoView.image = UIImage(data: data)
                                }else{
                                    print("There is no profile image in VC")
                                    self!.profilePhotoView.image = UIImage(named:"DefaultProfilePhoto")
                                }
                            }else{
                                self!.profilePhotoView.image = UIImage(named:"DefaultProfilePhoto")
                            }
                            
                            
                        }
                    })
                    self!.nickName.text = profile.username
                }
            }).disposed(by: bag)
            
            profilePhotoView.image = UIImage(named:"DefaultProfilePhoto")
            profilePhotoView.layer.borderColor = BLUE_COLOR.cgColor
            
            tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapModifyProfileBtn))
            profilePhotoView.addGestureRecognizer(tapGesture)
            profilePhotoView.isUserInteractionEnabled = true
            
            let smallConfig = UIImage.SymbolConfiguration(pointSize: 23, weight: .regular, scale: .large)
            
            modifyProfileBtn.setImage(UIImage(systemName:"pencil.circle.fill", withConfiguration: smallConfig)!.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
            modifyProfileBtn.addTarget(self, action: #selector(onTapModifyProfileBtn), for: .touchUpInside)
            modifyProfileBtn.isHidden = false
            modifyProfileBtn.isEnabled = true
            
            QABtn.removeTarget(nil, action: nil, for: .allEvents)
            QABtn.addTarget(self, action: #selector(onTapQABtn), for: .touchUpInside)
            
            heartedQBtn.removeTarget(nil, action: nil, for: .allEvents)
            heartedQBtn.addTarget(self, action: #selector(onTapHeartedQBtn), for: .touchUpInside)
            
            logInOutBtn.setImage(UIImage(systemName:"rectangle.portrait.and.arrow.right", withConfiguration: largeConfig)!.withTintColor(.darkText, renderingMode: .alwaysOriginal), for: .normal)
            logInOutBtn.setTitle("로그아웃", for: .normal)
            logInOutBtn.removeTarget(nil, action: nil, for: .allEvents)
            logInOutBtn.addTarget(self, action: #selector(onTapLogOutBtn), for: .touchUpInside)
        }else{
            profilePhotoView.image = UIImage(named:"DefaultProfilePhoto")
            profilePhotoView.layer.borderColor = .none
            
            tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapLogInBtn))
            profilePhotoView.addGestureRecognizer(tapGesture)
            profilePhotoView.isUserInteractionEnabled = true
            
            modifyProfileBtn.removeTarget(nil, action: nil, for: .allEvents)
            modifyProfileBtn.isHidden = true
            modifyProfileBtn.isEnabled = false
            
            nickName.text = "로그인해주세요"
            
            QABtn.removeTarget(nil, action: nil, for: .allEvents)
            QABtn.addTarget(self, action: #selector(onTapLogInBtn), for: .touchUpInside)
            
            heartedQBtn.removeTarget(nil, action: nil, for: .allEvents)
            heartedQBtn.addTarget(self, action: #selector(onTapLogInBtn), for: .touchUpInside)
            
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
        loadView()
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
                UserDefaults.standard.removeObject(forKey: "profileImage")
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
