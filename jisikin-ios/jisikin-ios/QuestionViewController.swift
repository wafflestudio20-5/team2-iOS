//
//  QuestionViewController.swift
//  jisikin-ios
//
//  Created by 김령교 on 2022/12/27.
//

import UIKit

extension UITextField {
    func setPlaceHolderColor(_ placeholderColor: UIColor) {
        attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: [
                .foregroundColor: placeholderColor,
                .font: font
            ].compactMapValues { $0 }
        )
    }
}

class QuestionViewController: UIViewController, UITextFieldDelegate {
    
    lazy var rightButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .plain, target: self, action: #selector(doneQuestion(_:)))
        btn.tintColor = .black
        return btn
    }()
    
    lazy var leftButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(leftButton(_:)))
        btn.tintColor = .black
        return btn
    }()
    
    lazy var plusImageButton: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(plusImage(_:)), for: .touchUpInside)
        btn.setImage(UIImage(systemName: "camera")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal), for: .normal)
        return btn
    }()
    
    lazy var addTagButton: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(addTag(_:)), for: .touchUpInside)
        btn.setTitle(" +  태그 입력", for: .normal)
        btn.backgroundColor = UIColor.white
        btn.setTitleColor(.lightGray, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        btn.contentHorizontalAlignment = .left
        return btn
    }()
    
    lazy var titleField: UITextField = {
        let field = UITextField()
        
        field.borderStyle = .none
        field.placeholder = "제목"
        field.font = .systemFont(ofSize: 25)
        field.setPlaceHolderColor(UIColor.lightGray)
        field.backgroundColor = UIColor.white
        field.delegate = self
        field.becomeFirstResponder()
        
        return field
    }()
    
    let textViewPlaceHolder = "무엇이 궁금한가요?"
    
    lazy var accessoryView: UIView = {
        return UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
    }()
    
    lazy var contentView: UITextView = {
        let view = UITextView()
        view.inputAccessoryView = accessoryView
        view.font = .systemFont(ofSize: 20)
        view.text = textViewPlaceHolder
        view.textColor = UIColor.lightGray
        view.delegate = self
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setLayout()
    }
    
    private func setNavigationBar() {
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.topItem?.title = "질문하기"
        navigationController?.navigationBar.topItem?.leftBarButtonItem = leftButton
        navigationController?.navigationBar.topItem?.rightBarButtonItem = rightButton
    }
    
    private func setLayout() {
        view.addSubview(titleField)
        view.addSubview(contentView)
        accessoryView.addSubview(plusImageButton)
        accessoryView.addSubview(addTagButton)
        
        guard let plusImageButtonSuperView = plusImageButton.superview else { return }
        
        titleField.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        plusImageButton.translatesAutoresizingMaskIntoConstraints = false
        addTagButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10.0),
            titleField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10.0),
            titleField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10.0),
            contentView.leadingAnchor.constraint(equalTo: titleField.leadingAnchor),
            contentView.rightAnchor.constraint(equalTo: titleField.rightAnchor),
            contentView.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 20),
            contentView.heightAnchor.constraint(equalToConstant: 300),
            plusImageButton.heightAnchor.constraint(equalToConstant: 38),
            plusImageButton.widthAnchor.constraint(equalToConstant: 38),
            plusImageButton.leftAnchor.constraint(equalTo: plusImageButtonSuperView.leftAnchor, constant: 1),
            plusImageButton.bottomAnchor.constraint(equalTo: plusImageButtonSuperView.bottomAnchor, constant: -1),
            addTagButton.heightAnchor.constraint(equalToConstant: 38),
            addTagButton.leftAnchor.constraint(equalTo: plusImageButtonSuperView.leftAnchor, constant: 1),
            addTagButton.rightAnchor.constraint(equalTo: plusImageButtonSuperView.rightAnchor, constant: -1),
            addTagButton.bottomAnchor.constraint(equalTo: plusImageButton.topAnchor)
        ])
    }
    
    @objc private func doneQuestion(_ sender: Any) {
            
    }
    
    @objc private func plusImage(_ sender: Any) {
        
    }
    
    @objc private func leftButton(_ sender: Any) {
        view.endEditing(true)
        //navigationController?.popViewController(animated: true)
    }
    
    @objc private func addTag(_ sender: Any) {
        
    }
}

extension QuestionViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceHolder {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceHolder
            textView.textColor = .lightGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let inputString = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let oldString = textView.text, let newRange = Range(range, in: oldString) else { return true }
        let newString = oldString.replacingCharacters(in: newRange, with: inputString).trimmingCharacters(in: .whitespacesAndNewlines)
        
        return true
    }
}
