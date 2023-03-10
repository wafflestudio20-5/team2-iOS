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
    
    var activeTextField = UITextField()
   
    var onLogin: (()->())?
    override func viewDidLoad() {
        viewInit()
        setLayout()
        setDesign()
    }
    
    func viewInit() {
        self.view.backgroundColor = UIColor(named: "BackgroundColor")
        
        usernameTextfield.delegate = self
        passwordTextfield.delegate = self
        
        usernameTextfield.enableInputAccessoryView()
        passwordTextfield.enableInputAccessoryView()
        
        usernameTextfield.customTextFieldDelegate = self
        passwordTextfield.customTextFieldDelegate = self
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
        signupButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 15).isActive = true
        kakaoLoginButton.topAnchor.constraint(equalTo: signupButton.bottomAnchor, constant: 20).isActive = true
        kakaoLoginButton.bottomAnchor.constraint(equalTo: kakaoLoginButton.topAnchor, constant: 50).isActive = true
    }
    
    func setDesign() {
        logoImgView.image = UIImage(named: "TextLogo")
        logoImgView.contentMode = .scaleAspectFit
        
        usernameTextfield.placeholder = "?????????"
        passwordTextfield.placeholder = "????????????"
        
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
        
        loginButton.setTitle("?????????", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        loginButton.backgroundColor = UIColor(named: "MainColor")
        loginButton.addTarget(self, action: #selector(tapLoginButton), for: .touchUpInside)
        
        signupButton.setTitle("????????????", for: .normal)
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
            usernameCriteriaLabel.text = "???????????? ??????????????????!"
        }
        
        else if(passwordTextfield.text == "") {
            usernameCriteriaLabel.text = ""
            passwordCriteriaLabel.text = "??????????????? ??????????????????!"
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
                
                else if(self.LoginRepo.error.deletedUser == true){
                    self.usernameCriteriaLabel.text = self.LoginRepo.errorMessage
                }
                
                else if(self.LoginRepo.error.hadError == true){
                    self.usernameCriteriaLabel.text = "error"
                }
                
                else {
                    UserDefaults.standard.set(true, forKey: "isLogin")
                    
                    self.usernameCriteriaLabel.text = ""
                    self.passwordCriteriaLabel.text = ""
                
                    if self.onLogin != nil{
                        self.onLogin!()
                    }
                    else{
                        self.navigationController?.popViewController(animated: true)
                    }
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
                
                if self.onLogin != nil{
                    self.onLogin!()
                }
                else{
                    self.navigationController?.popViewController(animated: true)
                }
            }
            
            else {
                let errorAlert = UIAlertController(title: nil, message: "????????? ??????", preferredStyle: .alert)
                let errorAction = UIAlertAction(title: "??????", style:UIAlertAction.Style.default)
                
                errorAlert.addAction(errorAction)
                
                self.present(errorAlert, animated: false)
                
            }
        })
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension LoginViewController: LoginTextFieldDelegate {
    func doneButtonPressed() {
        //
    }
    
    func arrowDownPressed() {
        switch activeTextField{
        case usernameTextfield:
            passwordTextfield.becomeFirstResponder()
        default:
            break
        }
    }
    
    func arrowUpPressed() {
        switch activeTextField{
        case passwordTextfield:
            usernameTextfield.becomeFirstResponder()
        default:
            break
        }
    }
}

protocol LoginTextFieldDelegate: AnyObject {
    func doneButtonPressed()
    func arrowDownPressed()
    func arrowUpPressed()
}

class TextFieldWithPadding: UITextField {
    weak var customTextFieldDelegate: LoginTextFieldDelegate?
    
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
    
    func enableInputAccessoryView() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)

        let doneButton = UIBarButtonItem(title: "??????", style: .done, target: self,
                                         action: #selector(textFieldDonePressed))
        doneButton.tintColor = UIColor(named: "MainColor")

        let arrowUp = UIBarButtonItem(image: UIImage(systemName: "chevron.up"), style: .plain, target: nil, action: #selector(arrowUpPressed))
        arrowUp.tintColor = UIColor(named: "MainColor")

        let arrowDown = UIBarButtonItem(image: UIImage(systemName: "chevron.down"), style: .plain, target: nil, action: #selector(arrowDownPressed))
        arrowDown.tintColor = UIColor(named: "MainColor")

        toolBar.setItems([arrowUp, arrowDown, space, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()

        inputAccessoryView = toolBar
    }

    @objc private func textFieldDonePressed() {
        endEditing(true)
        customTextFieldDelegate?.doneButtonPressed()
    }

    @objc private func arrowDownPressed() {
        customTextFieldDelegate?.arrowDownPressed()
    }

    @objc private func arrowUpPressed() {
        customTextFieldDelegate?.arrowUpPressed()
    }
}
