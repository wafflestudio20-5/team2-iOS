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
        let btn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneQuestion(_:)))
        return btn
    }()
    
    lazy var plusImageButton: UIButton = {
        let btn = UIButton()
    // 키보드 위에 태그 다는 텍스트필드랑 이미지 추가 버튼 다는 거부터 작업하면 됨
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
        
        return field
    }()
    
    let textViewPlaceHolder = "무엇이 궁금한가요?"
    
    lazy var accessoryView: UIView = {
        return UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 72))
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
    
    override func viewWillAppear(_ animated: Bool) {
        self.titleField.becomeFirstResponder()
    }
    
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
        navigationController?.navigationBar.topItem?.rightBarButtonItem = rightButton
    }
    
    private func setLayout() {
        view.addSubview(titleField)
        view.addSubview(contentView)
        
        titleField.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10.0),
            titleField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10.0),
            titleField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10.0),
            contentView.leadingAnchor.constraint(equalTo: titleField.leadingAnchor),
            contentView.rightAnchor.constraint(equalTo: titleField.rightAnchor),
            contentView.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 20),
            contentView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapContentView(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func didTapContentView(_ sender: Any) {
        view.endEditing(true)
    }
    
    @objc private func doneQuestion(_ sender: Any) {
            
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
