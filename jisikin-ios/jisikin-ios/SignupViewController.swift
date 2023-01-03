//
//  SignupViewController.swift
//  jisikin-ios
//
//  Created by Chaehyun Park on 2022/12/30.
//

import UIKit
import DropDown

class SignupViewController: UIViewController {
    let repo = LoginRepository()
    
    let logoImgView = UIImageView()
    let usernameLabel = UILabel()
    let usernameTextfield = TextFieldWithPadding()
    let usernameCriteriaLabel = UILabel()
    let passwordLabel = UILabel()
    let passwordTextfield = TextFieldWithPadding()
    let passwordCriteriaLabel = UILabel()
    let passwordRetypeLabel = UILabel()
    let passwordRetypeTextfield = TextFieldWithPadding()
    let passwordRetypeCriteriaLabel = UILabel()
    let nameLabel = UILabel()
    let nameTextfield = TextFieldWithPadding()
    let nameCriteriaLabel = UILabel()
    let genderLabel = UILabel()
    let genderButton = UIButton()
    let genderCriteriaLabel = UILabel()
    let dropDown = DropDown()
    let signupButton = UIButton()
    
    var isMale = false
    
    override func viewDidLoad() {
        viewInit()
        setLayout()
        setDesign()
    }
    
    func viewInit() {
        self.view.backgroundColor = UIColor(named: "BackgroundColor")
        let buttonConfig = UIButton.Configuration.plain()
        genderButton.configuration = buttonConfig
    }
    
    func setLayout() {

        logoImgView.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameTextfield.translatesAutoresizingMaskIntoConstraints = false
        usernameCriteriaLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTextfield.translatesAutoresizingMaskIntoConstraints = false
        passwordCriteriaLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordRetypeLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordRetypeTextfield.translatesAutoresizingMaskIntoConstraints = false
        passwordRetypeCriteriaLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameTextfield.translatesAutoresizingMaskIntoConstraints = false
        nameCriteriaLabel.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        genderButton.translatesAutoresizingMaskIntoConstraints = false
        genderCriteriaLabel.translatesAutoresizingMaskIntoConstraints = false
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(logoImgView)
        view.addSubview(usernameLabel)
        view.addSubview(usernameTextfield)
        view.addSubview(usernameCriteriaLabel)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextfield)
        view.addSubview(passwordCriteriaLabel)
        view.addSubview(passwordRetypeLabel)
        view.addSubview(passwordRetypeTextfield)
        view.addSubview(passwordRetypeCriteriaLabel)
        view.addSubview(nameLabel)
        view.addSubview(nameTextfield)
        view.addSubview(nameCriteriaLabel)
        view.addSubview(genderLabel)
        view.addSubview(genderButton)
        view.addSubview(genderCriteriaLabel)
        view.addSubview(signupButton)

        logoImgView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        logoImgView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: usernameTextfield.leadingAnchor).isActive = true
        usernameTextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        usernameTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        usernameCriteriaLabel.leadingAnchor.constraint(equalTo: usernameTextfield.leadingAnchor).isActive = true
        passwordLabel.leadingAnchor.constraint(equalTo: passwordTextfield.leadingAnchor).isActive = true
        passwordTextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        passwordTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        passwordCriteriaLabel.leadingAnchor.constraint(equalTo: passwordTextfield.leadingAnchor).isActive = true
        passwordRetypeLabel.leadingAnchor.constraint(equalTo: passwordRetypeTextfield.leadingAnchor).isActive = true
        passwordRetypeTextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        passwordRetypeTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        passwordRetypeCriteriaLabel.leadingAnchor.constraint(equalTo: passwordRetypeTextfield.leadingAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: nameTextfield.leadingAnchor).isActive = true
        nameTextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        nameTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        nameCriteriaLabel.leadingAnchor.constraint(equalTo: nameTextfield.leadingAnchor).isActive = true
        genderLabel.leadingAnchor.constraint(equalTo: genderButton.leadingAnchor).isActive = true
        genderButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        genderButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        genderCriteriaLabel.leadingAnchor.constraint(equalTo: genderButton.leadingAnchor).isActive = true
        signupButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        signupButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true

        
        logoImgView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        logoImgView.bottomAnchor.constraint(equalTo: logoImgView.topAnchor, constant: 70).isActive = true
        usernameLabel.topAnchor.constraint(equalTo: logoImgView.bottomAnchor, constant: 20).isActive = true
        usernameTextfield.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 5).isActive = true
        usernameTextfield.bottomAnchor.constraint(equalTo: usernameTextfield.topAnchor, constant: 50).isActive = true
        usernameCriteriaLabel.topAnchor.constraint(equalTo: usernameTextfield.bottomAnchor, constant:  5).isActive = true
        passwordLabel.topAnchor.constraint(equalTo: usernameCriteriaLabel.bottomAnchor, constant: 10).isActive = true
        passwordTextfield.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 5).isActive = true
        passwordTextfield.bottomAnchor.constraint(equalTo: passwordTextfield.topAnchor, constant: 50).isActive = true
        passwordCriteriaLabel.topAnchor.constraint(equalTo: passwordTextfield.bottomAnchor, constant: 5).isActive = true
        passwordRetypeLabel.topAnchor.constraint(equalTo: passwordCriteriaLabel.bottomAnchor, constant: 10).isActive = true
        passwordRetypeTextfield.topAnchor.constraint(equalTo: passwordRetypeLabel.bottomAnchor, constant: 5).isActive = true
        passwordRetypeTextfield.bottomAnchor.constraint(equalTo: passwordRetypeTextfield.topAnchor, constant: 50).isActive = true
        passwordRetypeCriteriaLabel.topAnchor.constraint(equalTo: passwordRetypeTextfield.bottomAnchor, constant: 5).isActive = true
        nameLabel.topAnchor.constraint(equalTo: passwordRetypeCriteriaLabel.bottomAnchor, constant: 10).isActive = true
        nameTextfield.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        nameTextfield.bottomAnchor.constraint(equalTo: nameTextfield.topAnchor, constant:50).isActive = true
        nameCriteriaLabel.topAnchor.constraint(equalTo: nameTextfield.bottomAnchor, constant: 5).isActive = true
        genderLabel.topAnchor.constraint(equalTo: nameCriteriaLabel.bottomAnchor, constant: 10).isActive = true
        genderButton.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 5).isActive = true
        genderButton.bottomAnchor.constraint(equalTo: genderButton.topAnchor, constant:50).isActive = true
        genderCriteriaLabel.topAnchor.constraint(equalTo: genderButton.bottomAnchor, constant: 5).isActive = true
        signupButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70).isActive = true
        signupButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true

    }
    
    func setDesign() {
        logoImgView.image = UIImage(named: "TextLogo")
        logoImgView.contentMode = .scaleAspectFit
        
        usernameLabel.text = "아이디"
        usernameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        usernameTextfield.backgroundColor = .white
        usernameTextfield.borderStyle = .line
        usernameTextfield.layer.borderColor = UIColor.lightGray.cgColor
        usernameTextfield.layer.borderWidth = 1.0
        usernameTextfield.addTarget(self, action: #selector(usernameTextfieldDidChange(_:)), for: .editingDidEnd)
        
        usernameCriteriaLabel.textColor = .red
        usernameCriteriaLabel.font = UIFont.systemFont(ofSize: 12)
        
        passwordLabel.text = "비밀번호"
        passwordLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        passwordTextfield.backgroundColor = .white
        passwordTextfield.borderStyle = .line
        passwordTextfield.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextfield.layer.borderWidth = 1.0
        passwordTextfield.isSecureTextEntry = true
        passwordTextfield.addTarget(self, action: #selector(passwordTextfieldDidChange(_:)), for: .editingDidEnd)

        passwordCriteriaLabel.textColor = .red
        passwordCriteriaLabel.font = UIFont.systemFont(ofSize: 12)
        
        passwordRetypeLabel.text = "비밀번호 재확인"
        passwordRetypeLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        passwordRetypeTextfield.backgroundColor = .white
        passwordRetypeTextfield.borderStyle = .line
        passwordRetypeTextfield.layer.borderColor = UIColor.lightGray.cgColor
        passwordRetypeTextfield.layer.borderWidth = 1.0
        passwordRetypeTextfield.isSecureTextEntry = true
        passwordRetypeTextfield.addTarget(self, action: #selector(passwordRetypeTextfieldDidChange(_:)), for: .editingDidEnd)

        passwordRetypeCriteriaLabel.textColor = .red
        passwordRetypeCriteriaLabel.font = UIFont.systemFont(ofSize: 12)

        nameLabel.text = "닉네임"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        nameTextfield.backgroundColor = .white
        nameTextfield.borderStyle = .line
        nameTextfield.layer.borderColor = UIColor.lightGray.cgColor
        nameTextfield.layer.borderWidth = 1.0
        nameTextfield.addTarget(self, action: #selector(nameTextfieldDidChange(_:)), for: .editingDidEnd)
        
        nameCriteriaLabel.textColor = .red
        nameCriteriaLabel.font = UIFont.systemFont(ofSize: 12)
        
        genderLabel.text = "성별"
        genderLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        genderCriteriaLabel.textColor = .red
        genderCriteriaLabel.font = UIFont.systemFont(ofSize: 12)
        
        dropDown.dataSource = ["성별", "남자", "여자"]
        dropDown.anchorView = genderButton
        
        dropDown.selectionAction = { [weak self] (index, item) in
            self!.genderButton.setTitle(item, for: .normal)
            
            if(self!.genderButton.title(for: .normal) == "성별") {
                self!.genderCriteriaLabel.text = "필수 정보입니다."
            }
            
            else {
                self!.genderCriteriaLabel.text = ""
            }
        }
        
        genderButton.setTitle("성별", for: .normal)
        genderButton.setTitleColor(.black, for: .normal)
        genderButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        genderButton.contentHorizontalAlignment = .fill
        genderButton.configuration?.imagePlacement = .trailing
        genderButton.backgroundColor = .white
        genderButton.layer.borderColor = UIColor.lightGray.cgColor
        genderButton.layer.borderWidth = 1.0
        genderButton.addTarget(self, action: #selector(tapGenderButton), for: .touchUpInside)
        
        signupButton.setTitle("회원가입", for: .normal)
        signupButton.setTitleColor(.white, for: .normal)
        signupButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        signupButton.backgroundColor = UIColor(named: "MainColor")
        signupButton.addTarget(self, action: #selector(tapSignupButton), for: .touchUpInside)
    }
    
    @objc func usernameTextfieldDidChange(_ textfield: UITextField) {
        
        if(textfield.text=="") {
            usernameCriteriaLabel.text = "필수 정보입니다."
        }
        
        else if (textfield.text!.count<5||textfield.text!.count>20||textfield.text!.range(of: "^[a-z0-9_\\-]*$", options: .regularExpression) == nil) {
            usernameCriteriaLabel.text = "5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다."
        }
        
        else {
            usernameCriteriaLabel.text = ""
        }
    }
    
    @objc func passwordTextfieldDidChange(_ textfield: UITextField) {
        
        if(textfield.text=="") {
            passwordCriteriaLabel.text = "필수 정보입니다."
        }
        
        else if (textfield.text!.count<8||textfield.text!.count>16||textfield.text!.range(of: "(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!\"#$%&'()*+,\\-./:;<=>?@\\[\\\\\\]^_`{|}~])", options: .regularExpression) == nil) {
            passwordCriteriaLabel.text = "8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요."
        }
        
        else {
            passwordCriteriaLabel.text = ""
        }
    }
    
    @objc func passwordRetypeTextfieldDidChange(_ textfield: UITextField) {
        
        if(textfield.text=="") {
            passwordRetypeCriteriaLabel.text = "필수 정보입니다."
        }
        
        else if (passwordTextfield.text != textfield.text) {
            passwordRetypeCriteriaLabel.text = "비밀번호가 일치하지 않습니다."
        }
        
        else {
            passwordRetypeCriteriaLabel.text = ""
        }
    }
    
    @objc func nameTextfieldDidChange(_ textfield: UITextField) {
        
        if(textfield.text=="") {
            nameCriteriaLabel.text = "필수 정보입니다."
        }
        
        else {
            nameCriteriaLabel.text = ""
        }
    }
    
    @objc func tapGenderButton() {
        dropDown.show()
    }
    

    @objc func tapSignupButton() {
        usernameTextfieldDidChange(usernameTextfield)
        passwordTextfieldDidChange(passwordTextfield)
        passwordRetypeTextfieldDidChange(passwordRetypeTextfield)
        nameTextfieldDidChange(nameTextfield)
        
        if(genderButton.title(for: .normal) == "성별") {
            genderCriteriaLabel.text = "필수 정보입니다."
        }
        
        else if(usernameCriteriaLabel.text == "" && passwordCriteriaLabel.text == "" && passwordRetypeCriteriaLabel.text == "" && nameCriteriaLabel.text == "") {
            
            if(genderButton.title(for: .normal) == "남자") {
                isMale = true
            }
            
            let account = SignUp(isMale: isMale, password: passwordTextfield.text!, uid: usernameTextfield.text!, username: nameTextfield.text!)
            repo.signUp(account: account, completionHandler: { _ in
                
                if(self.repo.error.uidExists == true) {
                    self.usernameCriteriaLabel.text = self.repo.errorMessage
                }
                
                else if(self.repo.error.usernameExists == true) {
                    self.nameCriteriaLabel.text = self.repo.errorMessage
                }
                
                else{
                    self.showAlert(message: "회원가입 성공", popVC: true)
                }
            })
        }
    }
    
    func showAlert(message: String, popVC: Bool){
        let setAlert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        
        var setAction: UIAlertAction
        
        if(popVC == true){
            setAction = UIAlertAction(title: "확인", style:UIAlertAction.Style.default, handler: { setAction in
                self.navigationController?.popViewController(animated: true)
            })
        }
        
        else {
            setAction = UIAlertAction(title: "확인", style:UIAlertAction.Style.default)
        }
        
        setAlert.addAction(setAction)
        
        self.present(setAlert, animated: false)
    }
}
