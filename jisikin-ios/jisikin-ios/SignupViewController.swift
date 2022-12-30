//
//  SignupViewController.swift
//  jisikin-ios
//
//  Created by Chaehyun Park on 2022/12/30.
//

import UIKit
import DropDown

class SignupViewController: UIViewController {
    
    let logoImgView = UIImageView()
    let usernameLabel = UILabel()
    let usernameTextfield = TextFieldWithPadding()
    let passwordLabel = UILabel()
    let passwordTextfield = TextFieldWithPadding()
    let passwordRetypeLabel = UILabel()
    let passwordRetypeTextfield = TextFieldWithPadding()
    let nameLabel = UILabel()
    let nameTextfield = TextFieldWithPadding()
    let genderLabel = UILabel()
    let genderTextfield = UIButton()
    let dropDown = DropDown()
    let signupButton = UIButton()
    
    override func viewDidLoad() {
        viewInit()
        setLayout()
        setDesign()
    }
    
    func viewInit() {
        self.view.backgroundColor = UIColor(named: "BackgroundColor")
        let buttonConfig = UIButton.Configuration.plain()
        genderTextfield.configuration = buttonConfig
    }
    
    func setLayout() {

        logoImgView.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameTextfield.translatesAutoresizingMaskIntoConstraints = false
        passwordLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordTextfield.translatesAutoresizingMaskIntoConstraints = false
        passwordRetypeLabel.translatesAutoresizingMaskIntoConstraints = false
        passwordRetypeTextfield.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameTextfield.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        genderTextfield.translatesAutoresizingMaskIntoConstraints = false
        signupButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(logoImgView)
        view.addSubview(usernameLabel)
        view.addSubview(usernameTextfield)
        view.addSubview(passwordLabel)
        view.addSubview(passwordTextfield)
        view.addSubview(passwordRetypeLabel)
        view.addSubview(passwordRetypeTextfield)
        view.addSubview(nameLabel)
        view.addSubview(nameTextfield)
        view.addSubview(genderLabel)
        view.addSubview(genderTextfield)
        view.addSubview(signupButton)

        logoImgView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        logoImgView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: usernameTextfield.leadingAnchor).isActive = true
        usernameTextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        usernameTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        passwordLabel.leadingAnchor.constraint(equalTo: passwordTextfield.leadingAnchor).isActive = true
        passwordTextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        passwordTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        passwordRetypeLabel.leadingAnchor.constraint(equalTo: passwordRetypeTextfield.leadingAnchor).isActive = true
        passwordRetypeTextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        passwordRetypeTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: nameTextfield.leadingAnchor).isActive = true
        nameTextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        nameTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        genderLabel.leadingAnchor.constraint(equalTo: genderTextfield.leadingAnchor).isActive = true
        genderTextfield.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        genderTextfield.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        signupButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        signupButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true

        
        logoImgView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        usernameLabel.topAnchor.constraint(equalTo: logoImgView.bottomAnchor).isActive = true
        usernameTextfield.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 5).isActive = true
        usernameTextfield.bottomAnchor.constraint(equalTo: usernameTextfield.topAnchor, constant: 50).isActive = true
        passwordLabel.topAnchor.constraint(equalTo: usernameTextfield.bottomAnchor, constant: 20).isActive = true
        passwordTextfield.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 5).isActive = true
        passwordTextfield.bottomAnchor.constraint(equalTo: passwordTextfield.topAnchor, constant: 50).isActive = true
        passwordRetypeLabel.topAnchor.constraint(equalTo: passwordTextfield.bottomAnchor, constant: 20).isActive = true
        passwordRetypeTextfield.topAnchor.constraint(equalTo: passwordRetypeLabel.bottomAnchor, constant: 5).isActive = true
        passwordRetypeTextfield.bottomAnchor.constraint(equalTo: passwordRetypeTextfield.topAnchor, constant: 50).isActive = true
        nameLabel.topAnchor.constraint(equalTo: passwordRetypeTextfield.bottomAnchor, constant: 20).isActive = true
        nameTextfield.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5).isActive = true
        nameTextfield.bottomAnchor.constraint(equalTo: nameTextfield.topAnchor, constant:50).isActive = true
        genderLabel.topAnchor.constraint(equalTo: nameTextfield.bottomAnchor, constant: 20).isActive = true
        genderTextfield.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 5).isActive = true
        genderTextfield.bottomAnchor.constraint(equalTo: genderTextfield.topAnchor, constant:50).isActive = true
        signupButton.topAnchor.constraint(equalTo: genderTextfield.bottomAnchor, constant: 20).isActive = true
        signupButton.bottomAnchor.constraint(equalTo: signupButton.topAnchor, constant: 60).isActive = true

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
        
        passwordLabel.text = "비밀번호"
        passwordLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        passwordTextfield.backgroundColor = .white
        passwordTextfield.borderStyle = .line
        passwordTextfield.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextfield.layer.borderWidth = 1.0
        passwordTextfield.isSecureTextEntry = true
        
        passwordRetypeLabel.text = "비밀번호 재확인"
        passwordRetypeLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        passwordRetypeTextfield.backgroundColor = .white
        passwordRetypeTextfield.borderStyle = .line
        passwordRetypeTextfield.layer.borderColor = UIColor.lightGray.cgColor
        passwordRetypeTextfield.layer.borderWidth = 1.0
        passwordRetypeTextfield.isSecureTextEntry = true
        
        nameLabel.text = "이름"
        nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        nameTextfield.backgroundColor = .white
        nameTextfield.borderStyle = .line
        nameTextfield.layer.borderColor = UIColor.lightGray.cgColor
        nameTextfield.layer.borderWidth = 1.0

        genderLabel.text = "성별"
        genderLabel.font = UIFont.boldSystemFont(ofSize: 15)
        
        dropDown.dataSource = ["남자", "여자"]
        dropDown.anchorView = genderTextfield
        
        dropDown.selectionAction = { [weak self] (index, item) in
            self!.genderTextfield.setTitle(item, for: .normal)
        }
        
        genderTextfield.setTitle("성별", for: .normal)
        genderTextfield.setTitleColor(.black, for: .normal)
        genderTextfield.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        genderTextfield.contentHorizontalAlignment = .fill
        genderTextfield.configuration?.imagePlacement = .trailing
        genderTextfield.backgroundColor = .white
        genderTextfield.layer.borderColor = UIColor.lightGray.cgColor
        genderTextfield.layer.borderWidth = 1.0
        genderTextfield.addTarget(self, action: #selector(tapGenderButton), for: .touchUpInside)

        
        signupButton.setTitle("회원가입", for: .normal)
        signupButton.setTitleColor(.white, for: .normal)
        signupButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
        signupButton.backgroundColor = UIColor(named: "MainColor")
        signupButton.addTarget(self, action: #selector(tapSignupButton), for: .touchUpInside)

    }
    
    @objc func tapGenderButton() {
        dropDown.show()
    }
    

    @objc func tapSignupButton() {
        self.navigationController?.popViewController(animated: true)
    }
}
