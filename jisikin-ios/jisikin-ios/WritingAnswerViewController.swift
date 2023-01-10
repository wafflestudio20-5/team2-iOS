//
//  WritingAnswerViewContorller.swift
//  jisikin-ios
//
//  Created by 홍희주 on 2023/01/04.
//

import UIKit

class WritingAnswerViewController: UIViewController {
    lazy var rightButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "답변등록", style: .plain, target: self, action: #selector(doneAnswer(_:)))
        btn.tintColor = BLUE_COLOR
        return btn
    }()
    
    lazy var viewQuestion: UIBarButtonItem = {
        let btn = UIBarButtonItem(title: "질문보기", style: .plain, target: self, action: #selector(viewQuestion(_:)))
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
        btn.setImage(systemName: "camera", color: UIColor.lightGray)
        return btn
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
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
        view.font = .systemFont(ofSize: 18)
        view.text = textViewPlaceHolder
        view.textColor = UIColor.lightGray
        view.delegate = self
        // view.becomeFirstResponder()
        
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
        self.navigationItem.rightBarButtonItems = [rightButton, viewQuestion]
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    private func setLayout() {
        view.addSubview(contentView)
        accessoryView.addSubview(plusImageButton)
        accessoryView.addSubview(lineView)
        
        guard let lineSuperView = plusImageButton.superview else { return }
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        plusImageButton.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10.0),
            contentView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10.0),
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10.0),
            contentView.heightAnchor.constraint(equalToConstant: 300),
            
            plusImageButton.heightAnchor.constraint(equalToConstant: 38),
            plusImageButton.widthAnchor.constraint(equalToConstant: 38),
            plusImageButton.leftAnchor.constraint(equalTo: lineSuperView.leftAnchor, constant: 5),
            plusImageButton.bottomAnchor.constraint(equalTo: lineSuperView.bottomAnchor, constant: -1),
            
            lineView.bottomAnchor.constraint(equalTo: plusImageButton.topAnchor, constant: -1),
            lineView.widthAnchor.constraint(equalTo: lineSuperView.widthAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.centerXAnchor.constraint(equalTo: lineSuperView.centerXAnchor),
        ])
    }
    
    @objc private func leftButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func doneAnswer(_ sender: Any) {
            
    }
    
    @objc private func plusImage(_ sender: Any) {
        
    }
    
    @objc private func viewQuestion(_ sender: Any) {
        
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
