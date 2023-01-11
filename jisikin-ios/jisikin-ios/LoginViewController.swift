//
//  LoginViewController.swift
//  jisikin-ios
//
//  Created by Chaehyun Park on 2022/12/30.
//

import UIKit

class LoginViewController: UIViewController {
    
    let logoImgView = UIImageView()
    let usernameTextfield = TextFieldWithPadding()
    let usernameCriteriaLabel = UILabel()
    let passwordTextfield = TextFieldWithPadding()
    let passwordCriteriaLabel = UILabel()
    let loginButton = UIButton()
    let signupButton = UIButton()
    let kakaoLoginButton = UIButton()
    
    let LoginRepo = LoginRepository()
    
    override func viewDidLoad() {
        viewInit()
        setLayout()
        setDesign()
    }
    
    func viewInit() {
        self.view.backgroundColor = UIColor(named: "BackgroundColor")
    }
    
    func setLayout() {
        logoImgView.translatesAutoresizingMaskIntoConstraints = false
        usernameTextfield.translatesAutoresizingMaskIntoConstraints = false
        usernameCriteriaLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTextfield.translatesAutoresizingMaskIntoConstraints = false
        passwordCriteriaLabel.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        kakaoLoginButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(logoImgView)
        view.addSubview(usernameTextfield)
        view.addSubview(usernameCriteriaLabel)
        view.addSubview(passwordTextfield)
        view.addSubview(passwordCriteriaLabel)
        view.addSubview(loginButton)
        view.addSubview(signupButton)
        view.addSubview(kakaoLoginButton)

        logoImgView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        logoImgView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        usernameTextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        usernameTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        usernameCriteriaLabel.leadingAnchor.constraint(equalTo: usernameTextfield.leadingAnchor).isActive = true
        passwordTextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        passwordTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        passwordCriteriaLabel.leadingAnchor.constraint(equalTo: passwordTextfield.leadingAnchor).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        signupButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        kakaoLoginButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
        kakaoLoginButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true
        
        
        logoImgView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        logoImgView.bottomAnchor.constraint(equalTo: logoImgView.topAnchor, constant: 70).isActive = true
        usernameTextfield.topAnchor.constraint(equalTo: logoImgView.bottomAnchor, constant: 30).isActive = true
        usernameTextfield.bottomAnchor.constraint(equalTo: usernameTextfield.topAnchor, constant: 40).isActive = true
        usernameCriteriaLabel.topAnchor.constraint(equalTo: usernameTextfield.bottomAnchor, constant: 5).isActive = true
        passwordTextfield.topAnchor.constraint(equalTo: usernameCriteriaLabel.bottomAnchor, constant: 20).isActive = true
        passwordTextfield.bottomAnchor.constraint(equalTo: passwordTextfield.topAnchor, constant: 40).isActive = true
        passwordCriteriaLabel.topAnchor.constraint(equalTo: passwordTextfield.bottomAnchor, constant: 5).isActive = true
        loginButton.topAnchor.constraint(equalTo: passwordCriteriaLabel.bottomAnchor, constant: 20).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: 60).isActive = true
        signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20).isActive = true
        kakaoLoginButton.topAnchor.constraint(equalTo: signupButton.bottomAnchor, constant: 30).isActive = true
        kakaoLoginButton.bottomAnchor.constraint(equalTo: kakaoLoginButton.topAnchor, constant: 50).isActive = true
    }
    
    func setDesign() {
        logoImgView.image = UIImage(named: "TextLogo")
        logoImgView.contentMode = .scaleAspectFit
        
        usernameTextfield.placeholder = "아이디"
        passwordTextfield.placeholder = "비밀번호"
        
        usernameTextfield.backgroundColor = .white
        usernameTextfield.borderStyle = .line
        usernameTextfield.layer.borderColor = UIColor.lightGray.cgColor
        usernameTextfield.layer.borderWidth = 1.0
        
        usernameCriteriaLabel.textColor = .red
        usernameCriteriaLabel.font = UIFont.systemFont(ofSize: 12)
        
        passwordTextfield.backgroundColor = .white
        passwordTextfield.borderStyle = .line
        passwordTextfield.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextfield.layer.borderWidth = 1.0
        passwordTextfield.isSecureTextEntry = true
        
        passwordCriteriaLabel.textColor = .red
        passwordCriteriaLabel.font = UIFont.systemFont(ofSize: 12)
        
        loginButton.setTitle("로그인", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        loginButton.backgroundColor = UIColor(named: "MainColor")
        loginButton.addTarget(self, action: #selector(tapLoginButton), for: .touchUpInside)
        
        signupButton.setTitle("회원가입", for: .normal)
        signupButton.setTitleColor(.lightGray, for: .normal)
        signupButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        signupButton.addTarget(self, action: #selector(tapSignupButton), for: .touchUpInside)
        
        kakaoLoginButton.setImage(UIImage(named: "KakaoLogin"), for: .normal)
        kakaoLoginButton.contentMode = .scaleAspectFit
        kakaoLoginButton.addTarget(self, action: #selector(tapKakaoLoginButton), for: .touchUpInside)
    }
    
    @objc func tapLoginButton() {
        
        if(usernameTextfield.text == "") {
            passwordTextfield.text = ""
            usernameCriteriaLabel.text = "아이디를 입력해주세요!"
        }
        
        else if(passwordTextfield.text == "") {
            usernameCriteriaLabel.text = ""
            passwordCriteriaLabel.text = "비밀번호를 입력해주세요!"
        }
        
        else {
            usernameCriteriaLabel.text = ""
            passwordCriteriaLabel.text = ""
            
            
            LoginRepo.login(param: Login(ID: usernameTextfield.text!, password: passwordTextfield.text!), completionHandler: { _ in
                
                if(self.LoginRepo.error.uidWrong == true) {
                    self.usernameCriteriaLabel.text = self.LoginRepo.errorMessage
                }
                
                else if(self.LoginRepo.error.passwordWrong == true) {
                    self.passwordCriteriaLabel.text = self.LoginRepo.errorMessage
                }
                
                else {
                    UserDefaults.standard.set(true, forKey: "isLogin")
                    
                    self.usernameCriteriaLabel.text = ""
                    self.passwordCriteriaLabel.text = ""
                    let loginAlert = UIAlertController(title: nil, message: "로그인 성공", preferredStyle: .alert)
                    let loginAction = UIAlertAction(title: "확인", style:UIAlertAction.Style.default, handler: { loginAction in
                        self.navigationController?.popViewController(animated: true)
                    })
                    
                    loginAlert.addAction(loginAction)
                    
                    self.present(loginAlert, animated: false)
                }
            })
        }
    }

    @objc func tapSignupButton() {
        let vc = SignupViewController()
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = UIColor(named: "MainColor")
        self.navigationItem.backBarButtonItem = backBarButtonItem
        self.navigationController?.present(vc, animated: true)
    }
    
    @objc func tapKakaoLoginButton() {
        LoginRepo.kakaoLogin(completionHandler: { completionHandler in
            
            if(completionHandler == "success"){
                UserDefaults.standard.set(true, forKey: "isLogin")
                
                let loginAlert = UIAlertController(title: nil, message: "로그인 성공", preferredStyle: .alert)
                let loginAction = UIAlertAction(title: "확인", style:UIAlertAction.Style.default, handler: { loginAction in
                    self.navigationController?.popViewController(animated: true)
                })
                
                loginAlert.addAction(loginAction)
                
                self.present(loginAlert, animated: false)
            }
            
            else {
                let errorAlert = UIAlertController(title: nil, message: "로그인 실패", preferredStyle: .alert)
                let errorAction = UIAlertAction(title: "확인", style:UIAlertAction.Style.default)
                
                errorAlert.addAction(errorAction)
                
                self.present(errorAlert, animated: false)
                
            }
        })
    }
}


class TextFieldWithPadding: UITextField {
    weak var customTextFieldDelegate: MyCustomTextFieldDelegate?
    
    var textPadding = UIEdgeInsets(
        top: 10,
        left: 10,
        bottom: 10,
        right: 10
    )
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}
