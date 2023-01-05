//
//  WritingAnswerViewContorller.swift
//  jisikin-ios
//
//  Created by 홍희주 on 2023/01/04.
//

import UIKit

class WritingAnswerViewController: UIViewController {
    lazy var rightButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAnswer(_:)))
        return btn
    }()
    
    lazy var plusImageButton: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(plusImage(_:)), for: .touchUpInside)
        btn.setTitle("📷", for: .normal)
        btn.backgroundColor = BLUE_COLOR
        btn.layer.cornerRadius = 10
        return btn
    }()
    
    lazy var keyboardDownButton: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(hideKeyboard(_:)), for: .touchUpInside)
        btn.setTitle("↓", for: .normal)
        btn.backgroundColor = BLUE_COLOR
        btn.layer.cornerRadius = 10
        return btn
    }()
  
    let textViewPlaceHolder = """
    답변 작성 시 서비스 운영정책을 지켜주세요.
    
    광고주로부터 소정의 경제적 대가를 받고 특정상품에 대한 추천 또는 후기글을 올리는 경우, 이러한 광고주와의 경제적 이해 관계를 소비자들이 쉽게 알 수 있도록 글 제목 또는 답변의 첫 부분 또는 끝 부분 등 적절한 위치에 공개하여야 합니다.
    """
    
    lazy var accessoryView: UIView = {
        return UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
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
        
        self.navigationController?.isNavigationBarHidden = false
        self.title = "답변하기"
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    private func setLayout() {
        view.addSubview(contentView)
        accessoryView.addSubview(plusImageButton)
        accessoryView.addSubview(keyboardDownButton)
        
        guard let plusImageButtonSuperView = plusImageButton.superview else { return }
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        plusImageButton.translatesAutoresizingMaskIntoConstraints = false
        keyboardDownButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10.0),
            contentView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10.0),
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10.0),
            contentView.heightAnchor.constraint(equalToConstant: 300),
            plusImageButton.heightAnchor.constraint(equalToConstant: 48),
            plusImageButton.widthAnchor.constraint(equalToConstant: 48),
            plusImageButton.leftAnchor.constraint(equalTo: plusImageButtonSuperView.leftAnchor, constant: 1),
            plusImageButton.topAnchor.constraint(equalTo: plusImageButtonSuperView.topAnchor, constant: 1),
            keyboardDownButton.heightAnchor.constraint(equalToConstant: 48),
            keyboardDownButton.widthAnchor.constraint(equalToConstant: 48),
            keyboardDownButton.rightAnchor.constraint(equalTo: plusImageButtonSuperView.rightAnchor, constant: -1),
            keyboardDownButton.topAnchor.constraint(equalTo: plusImageButtonSuperView.topAnchor, constant: 1)
        ])
    }
    
    @objc private func doneAnswer(_ sender: Any) {
            
    }
    
    @objc private func plusImage(_ sender: Any) {
        
    }
    
    @objc private func hideKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
}

extension WritingAnswerViewController: UITextViewDelegate {
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
