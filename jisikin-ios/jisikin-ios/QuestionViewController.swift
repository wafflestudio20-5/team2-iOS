//
//  QuestionViewController.swift
//  jisikin-ios
//
//  Created by 김령교 on 2022/12/27.
//

import UIKit

extension UIButton {

    func setImage(systemName: String, color: UIColor) {
        contentHorizontalAlignment = .fill
        contentVerticalAlignment = .fill
        
        imageView?.tintColor = color
        imageView?.contentMode = .scaleAspectFit
        imageEdgeInsets = .zero
        
        setImage(UIImage(systemName: systemName), for: .normal)
    }
}

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
    
    var tags: [String] = []
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 13
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(tagViewCell.self, forCellWithReuseIdentifier: "tagViewCell")
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = .zero
        
        return collectionView
    }()
    
    lazy var rightButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(image: UIImage(systemName: "checkmark"), style: .plain, target: self, action: #selector(doneQuestion(_:)))
        btn.tintColor = .white
        return btn
    }()
    
    lazy var leftButton: UIBarButtonItem = {
        let btn = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(leftButton(_:)))
        btn.tintColor = .white
        return btn
    }()
    
    lazy var addTagButton: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(addTag(_:)), for: .touchUpInside)
        btn.setImage(systemName: "plus", color: UIColor.gray)
        return btn
    }()
    
    lazy var plusImageButton: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(plusImage(_:)), for: .touchUpInside)
        btn.setImage(systemName: "camera", color: UIColor.lightGray)
        return btn
    }()
    
    lazy var topLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var titleField: UITextField = {
        let field = UITextField()
        
        field.borderStyle = .none
        field.placeholder = "제목"
        field.font = .systemFont(ofSize: 23)
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
        view.font = .systemFont(ofSize: 18)
        view.text = textViewPlaceHolder
        view.textColor = UIColor.lightGray
        view.delegate = self
        view.backgroundColor = .white
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        collectionView.dataSource = self
        collectionView.delegate = self
        setLayout()
    }
    
    private func setNavigationBar() {
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = BLUE_COLOR
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.topItem?.title = "질문하기"
        navigationController?.navigationBar.topItem?.leftBarButtonItem = leftButton
        navigationController?.navigationBar.topItem?.rightBarButtonItem = rightButton
    }
    
    private func setLayout() {
        view.addSubview(titleField)
        view.addSubview(topLineView)
        view.addSubview(contentView)
        accessoryView.addSubview(plusImageButton)
        accessoryView.addSubview(lineView)
        accessoryView.addSubview(collectionView)
        accessoryView.addSubview(addTagButton)
        
        guard let lineSuperView = lineView.superview else { return }
        
        titleField.translatesAutoresizingMaskIntoConstraints = false
        topLineView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        plusImageButton.translatesAutoresizingMaskIntoConstraints = false
        addTagButton.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10.0),
            titleField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -10.0),
            titleField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10.0),
            
            topLineView.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 10),
            topLineView.heightAnchor.constraint(equalToConstant: 1),
            topLineView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, constant: -20),
            topLineView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: titleField.leadingAnchor, constant: -3),
            contentView.rightAnchor.constraint(equalTo: titleField.rightAnchor),
            contentView.topAnchor.constraint(equalTo: titleField.bottomAnchor, constant: 20),
            contentView.heightAnchor.constraint(equalToConstant: 300),
            
            plusImageButton.heightAnchor.constraint(equalToConstant: 38),
            plusImageButton.widthAnchor.constraint(equalToConstant: 38),
            plusImageButton.leftAnchor.constraint(equalTo: lineSuperView.leftAnchor, constant: 5),
            plusImageButton.bottomAnchor.constraint(equalTo: lineSuperView.bottomAnchor, constant: -1),
            
            lineView.bottomAnchor.constraint(equalTo: plusImageButton.topAnchor, constant: -1),
            lineView.widthAnchor.constraint(equalTo: lineSuperView.widthAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.centerXAnchor.constraint(equalTo: lineSuperView.centerXAnchor),
            
            collectionView.leftAnchor.constraint(equalTo: addTagButton.rightAnchor, constant: 10),
            collectionView.rightAnchor.constraint(equalTo: lineSuperView.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: plusImageButton.topAnchor, constant: -10),
            collectionView.heightAnchor.constraint(equalToConstant: 22),
            
            addTagButton.heightAnchor.constraint(equalToConstant: 20),
            addTagButton.leftAnchor.constraint(equalTo: lineSuperView.leftAnchor, constant: 10),
            addTagButton.widthAnchor.constraint(equalToConstant: 20),
            addTagButton.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor)
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
        let controller = UIAlertController(title: nil, message: "태그를 입력하세요", preferredStyle: .alert)
        controller.addTextField { field in
            field.placeholder = "최대 20자까지 입력"
        }
        
        let okAction = UIAlertAction(title: "추가", style: .default) { action in
            if (controller.textFields?.first!.text ?? "").count < 1 {
                return
            }
            
            // 텍스트 내용 전달해서 cell의 label의 텍스트 바꾸기
            guard let tag = controller.textFields?.first!.text else { return }
            self.tags.append(tag)
            self.collectionView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .default)
        
        controller.addAction(okAction)
        controller.addAction(cancelAction)
        
        present(controller, animated: true, completion: nil)
    }
}

extension QuestionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tagViewCell.identifier, for: indexPath) as? tagViewCell else {
            return UICollectionViewCell()
        }
        cell.tagLabel.text = "#" + self.tags[indexPath.row]
        cell.xButton.tag = indexPath.row
        cell.xButton.addTarget(self, action: #selector(xButtonPressed(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tags.count
    }
    
    @objc private func xButtonPressed(sender: UIButton) {
        collectionView.deleteItems(at: [IndexPath.init(row: sender.tag, section: 0)])
        tags.remove(at: sender.tag)
    }
}

extension QuestionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel()
        label.text = "#" + self.tags[indexPath.row]
        label.font = .systemFont(ofSize: 18)
        label.sizeToFit()
        let cellWidth = label.frame.width + 22
        
        return CGSize(width: cellWidth, height: 22)
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
