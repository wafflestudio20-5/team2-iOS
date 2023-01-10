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
    
    let scrollView : UIScrollView! = UIScrollView()
    let contentView : UIStackView! = UIStackView()
    
    var keyHeight: CGFloat!
    
    var activeTextField = UITextField()
    
    let logoImgView = UIImageView()
    let usernameLabel = UILabel()
    let usernameTextfield = TextFieldWithPaddingForSignup()
    let usernameCriteriaLabel = UILabel()
    let passwordLabel = UILabel()
    let passwordTextfield = TextFieldWithPaddingForSignup()
    let passwordCriteriaLabel = UILabel()
    let passwordRetypeLabel = UILabel()
    let passwordRetypeTextfield = TextFieldWithPaddingForSignup()
    let passwordRetypeCriteriaLabel = UILabel()
    let nameLabel = UILabel()
    let nameTextfield = TextFieldWithPaddingForSignup()
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
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        usernameTextfield.delegate = self
        passwordTextfield.delegate = self
        passwordRetypeTextfield.delegate = self
        nameTextfield.delegate = self
        
        usernameTextfield.enableInputAccessoryView()
        passwordTextfield.enableInputAccessoryView()
        passwordRetypeTextfield.enableInputAccessoryView()
        nameTextfield.enableInputAccessoryView()
        
        usernameTextfield.customTextFieldDelegate = self
        passwordTextfield.customTextFieldDelegate = self
        passwordRetypeTextfield.customTextFieldDelegate = self
        nameTextfield.customTextFieldDelegate = self
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)

        let buttonConfig = UIButton.Configuration.plain()
        genderButton.configuration = buttonConfig
    }
    
    func setLayout() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

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
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
        ])

        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        let contentViewHeight = contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        contentViewHeight.priority = .defaultLow
        contentViewHeight.isActive = true
        
        contentView.addSubview(logoImgView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(usernameTextfield)
        contentView.addSubview(usernameCriteriaLabel)
        contentView.addSubview(passwordLabel)
        contentView.addSubview(passwordTextfield)
        contentView.addSubview(passwordCriteriaLabel)
        contentView.addSubview(passwordRetypeLabel)
        contentView.addSubview(passwordRetypeTextfield)
        contentView.addSubview(passwordRetypeCriteriaLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(nameTextfield)
        contentView.addSubview(nameCriteriaLabel)
        contentView.addSubview(genderLabel)
        contentView.addSubview(genderButton)
        contentView.addSubview(genderCriteriaLabel)
        contentView.addSubview(signupButton)
        
        NSLayoutConstraint.activate([
            logoImgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            logoImgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            usernameLabel.leadingAnchor.constraint(equalTo: usernameTextfield.leadingAnchor),
            usernameTextfield.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            usernameTextfield.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            usernameCriteriaLabel.leadingAnchor.constraint(equalTo: usernameTextfield.leadingAnchor),
            passwordLabel.leadingAnchor.constraint(equalTo: passwordTextfield.leadingAnchor),
            passwordTextfield.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            passwordTextfield.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            passwordCriteriaLabel.leadingAnchor.constraint(equalTo: passwordTextfield.leadingAnchor),
            passwordRetypeLabel.leadingAnchor.constraint(equalTo: passwordRetypeTextfield.leadingAnchor),
            passwordRetypeTextfield.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            passwordRetypeTextfield.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            passwordRetypeCriteriaLabel.leadingAnchor.constraint(equalTo: passwordRetypeTextfield.leadingAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: nameTextfield.leadingAnchor),
            nameTextfield.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            nameTextfield.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            nameCriteriaLabel.leadingAnchor.constraint(equalTo: nameTextfield.leadingAnchor),
            genderLabel.leadingAnchor.constraint(equalTo: genderButton.leadingAnchor),
            genderButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            genderButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            genderCriteriaLabel.leadingAnchor.constraint(equalTo: genderButton.leadingAnchor),
            signupButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            signupButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
       

        NSLayoutConstraint.activate([
            logoImgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            logoImgView.bottomAnchor.constraint(equalTo: logoImgView.topAnchor, constant: 70),
            usernameLabel.topAnchor.constraint(equalTo: logoImgView.bottomAnchor, constant: 20),
            usernameTextfield.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 5),
            usernameTextfield.bottomAnchor.constraint(equalTo: usernameTextfield.topAnchor, constant: 50),
            usernameCriteriaLabel.topAnchor.constraint(equalTo: usernameTextfield.bottomAnchor, constant:  5),
            passwordLabel.topAnchor.constraint(equalTo: usernameCriteriaLabel.bottomAnchor, constant: 10),
            passwordTextfield.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 5),
            passwordTextfield.bottomAnchor.constraint(equalTo: passwordTextfield.topAnchor, constant: 50),
            passwordCriteriaLabel.topAnchor.constraint(equalTo: passwordTextfield.bottomAnchor, constant: 5),
            passwordRetypeLabel.topAnchor.constraint(equalTo: passwordCriteriaLabel.bottomAnchor, constant: 10),
            passwordRetypeTextfield.topAnchor.constraint(equalTo: passwordRetypeLabel.bottomAnchor, constant: 5),
            passwordRetypeTextfield.bottomAnchor.constraint(equalTo: passwordRetypeTextfield.topAnchor, constant: 50),
            passwordRetypeCriteriaLabel.topAnchor.constraint(equalTo: passwordRetypeTextfield.bottomAnchor, constant: 5),
            nameLabel.topAnchor.constraint(equalTo: passwordRetypeCriteriaLabel.bottomAnchor, constant: 10),
            nameTextfield.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            nameTextfield.bottomAnchor.constraint(equalTo: nameTextfield.topAnchor, constant:50),
            nameCriteriaLabel.topAnchor.constraint(equalTo: nameTextfield.bottomAnchor, constant: 5),
            genderLabel.topAnchor.constraint(equalTo: nameCriteriaLabel.bottomAnchor, constant: 10),
            genderButton.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 5),
            genderButton.bottomAnchor.constraint(equalTo: genderButton.topAnchor, constant:50),
            genderCriteriaLabel.topAnchor.constraint(equalTo: genderButton.bottomAnchor, constant: 5),
            signupButton.topAnchor.constraint(equalTo: genderButton.bottomAnchor, constant: 50),
            signupButton.bottomAnchor.constraint(equalTo: signupButton.topAnchor, constant: 50),
        ])
        

        scrollView.updateContentSize()

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
        genderButton.tintColor = UIColor(named: "MainColor")
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
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func usernameTextfieldDidChange(_ textfield: UITextField) {
        
        if(textfield.text=="") {
            usernameCriteriaLabel.text = "필수 정보입니다."
            scrollView.updateContentSize()
        }
        
        else if (textfield.text!.count<5||textfield.text!.count>20||textfield.text!.range(of: "^[a-z0-9_]*$", options: .regularExpression) == nil) {
            usernameCriteriaLabel.text = "5~20자의 영문 소문자, 숫자와 특수기호(_)만 사용 가능합니다."
            scrollView.updateContentSize()
        }
        
        else {
            usernameCriteriaLabel.text = ""
            scrollView.updateContentSize()
        }
    }
    
    @objc func passwordTextfieldDidChange(_ textfield: UITextField) {
        
        if(textfield.text=="") {
            passwordCriteriaLabel.text = "필수 정보입니다."
            scrollView.updateContentSize()
        }
        
        else if (textfield.text!.count<8||textfield.text!.count>16||textfield.text!.range(of: "(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[!\"#$%&'()*+,\\-./:;<=>?@\\[\\\\\\]^_`{|}~])", options: .regularExpression) == nil) {
            passwordCriteriaLabel.text = "8~16자 영문 대 소문자, 숫자, 특수문자를 사용하세요."
            scrollView.updateContentSize()
        }
        
        else {
            passwordCriteriaLabel.text = ""
            scrollView.updateContentSize()
        }
    }
    
    @objc func passwordRetypeTextfieldDidChange(_ textfield: UITextField) {
        
        if(textfield.text=="") {
            passwordRetypeCriteriaLabel.text = "필수 정보입니다."
            scrollView.updateContentSize()
        }
        
        else if (passwordTextfield.text != textfield.text) {
            passwordRetypeCriteriaLabel.text = "비밀번호가 일치하지 않습니다."
            scrollView.updateContentSize()
        }
        
        else {
            passwordRetypeCriteriaLabel.text = ""
            scrollView.updateContentSize()
        }
    }
    
    @objc func nameTextfieldDidChange(_ textfield: UITextField) {
        
        if(textfield.text=="") {
            nameCriteriaLabel.text = "필수 정보입니다."
            scrollView.updateContentSize()
        }
        
        else {
            nameCriteriaLabel.text = ""
            scrollView.updateContentSize()
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
            scrollView.updateContentSize()
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
    
    @objc func keyboardWillShow(_ sender: Notification) {
        self.keyboardWillHide(sender)
        let userInfo: NSDictionary = sender.userInfo! as NSDictionary
        let keyboardFrame: NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        keyHeight = keyboardHeight
        
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: keyHeight+50, right: 0)
    
        scrollView.contentInset = insets
        scrollView.scrollIndicatorInsets = insets
    }

    @objc func keyboardWillHide(_ sender: Notification) {
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        scrollView.contentInset = insets
        scrollView.scrollIndicatorInsets = insets
    }
}


extension SignupViewController: UITextFieldDelegate {
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

extension UIScrollView {
    func updateContentSize() {
        let unionCalculatedTotalRect = recursiveUnionInDepthFor(view: self)
        
        self.contentSize = CGSize(width: self.frame.width, height: unionCalculatedTotalRect.height-50)
    }
    
    private func recursiveUnionInDepthFor(view: UIView) -> CGRect {
        var totalRect: CGRect = .zero
        
        for subView in view.subviews {
            totalRect = totalRect.union(recursiveUnionInDepthFor(view: subView))
        }
        
        return totalRect.union(view.frame)
    }
}

extension SignupViewController: MyCustomTextFieldDelegate {
    func doneButtonPressed() {
        //
    }
    
    func arrowDownPressed() {
        switch activeTextField{
        case usernameTextfield:
            passwordTextfield.becomeFirstResponder()
        case passwordTextfield:
            passwordRetypeTextfield.becomeFirstResponder()
        case passwordRetypeTextfield:
            nameTextfield.becomeFirstResponder()
        default:
            break
        }
    }
    
    func arrowUpPressed() {
        switch activeTextField{
        case passwordTextfield:
            usernameTextfield.becomeFirstResponder()
        case passwordRetypeTextfield:
            passwordTextfield.becomeFirstResponder()
        case nameTextfield:
            passwordRetypeTextfield.becomeFirstResponder()
        default:
            break
        }
    }
}

protocol MyCustomTextFieldDelegate: AnyObject {
    func doneButtonPressed()
    func arrowDownPressed()
    func arrowUpPressed()
}

class TextFieldWithPaddingForSignup: UITextField {
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

    func enableInputAccessoryView() {
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)

        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self,
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
