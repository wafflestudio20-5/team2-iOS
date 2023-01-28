//
//  WritingAnswerViewContorller.swift
//  jisikin-ios
//
//  Created by 홍희주 on 2023/01/04.
//

import UIKit
import Photos
import BSImagePicker

class WritingAnswerViewController: UIViewController {
    
    var viewModel = QuestionListViewModel(usecase:QuestionAnswerUsecase())
  
    var questionID: Int = -1
    
    var photos: [UIImage] = []
    var content:String? = ""
    var isEdit = false
    var cnt: Int = 0
    
    var imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 2
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(ImageViewCell.self, forCellWithReuseIdentifier: "ImageViewCell")
        collectionView.isScrollEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = .zero
        
        return collectionView
    }()
    
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
        return UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 170))
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
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self
        setNavigationBar()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.contentView.becomeFirstResponder()
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
        accessoryView.addSubview(imageCollectionView)
        
        guard let lineSuperView = plusImageButton.superview else { return }
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        plusImageButton.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false
        imageCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
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
            lineView.centerXAnchor.constraint(equalTo: lineSuperView.centerXAnchor),imageCollectionView.leftAnchor.constraint(equalTo: lineSuperView.leftAnchor, constant: 10),
            imageCollectionView.rightAnchor.constraint(equalTo: lineSuperView.rightAnchor),
            imageCollectionView.heightAnchor.constraint(equalToConstant: 120),
            imageCollectionView.bottomAnchor.constraint(equalTo: lineView.topAnchor, constant: -3)
        ])
    }
    
    @objc private func leftButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func doneAnswer(_ sender: Any) {
        if contentView.text == textViewPlaceHolder {
            let alert = UIAlertController(title: "주의", message: "내용을 입력하세요.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
        } else {
            guard let contentText = contentView.text else { return }
            viewModel.postNewAnswer(id: questionID, contentText: contentText, photos: self.photos){
                result in
                if result == "success"{
                 
                    self.navigationController?.popViewController(animated: false)
                }
            }
        }
       
    }
    
    @objc private func plusImage(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: "이미지 삽입", preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let album = UIAlertAction(title: "사진 보관함", style: .default) {
            [weak self] (_) in
            self?.presentAlbum()
        }
        let camera = UIAlertAction(title: "사진 찍기", style: .default) {
            [weak self] (_) in
            self?.presentCamera()
        }
        
        alert.addAction(cancel)
        alert.addAction(camera)
        alert.addAction(album)
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func viewQuestion(_ sender: Any) {
        let viewModel = QuestionListViewModel(usecase:QuestionAnswerUsecase())
        viewModel.getQuestionsByDate()
        
        self.navigationController?.present(QuestionDetailFromWritingAnswerViewController(viewModel: QuestionDetailViewModel(usecase: viewModel.usecase, questionID: self.questionID)), animated: true)
    }
}

extension WritingAnswerViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        
        present(vc, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if cnt % 2 == 0 {
            if let image = info[.editedImage] as? UIImage {
                self.photos.append(image)
            }
        }
        else {
            if let image = info[.originalImage] as? UIImage {
                self.photos.append(image)
            }
        }
        
        cnt += 1
        self.imageCollectionView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    func presentAlbum() {
        let imagePicker = ImagePickerController()
        
        imagePicker.modalPresentationStyle = .fullScreen
        imagePicker.settings.selection.max = 20
        imagePicker.settings.theme.backgroundColor = .white
        imagePicker.settings.theme.selectionStyle = .numbered
        imagePicker.settings.fetch.assets.supportedMediaTypes = [.image]
        imagePicker.settings.theme.selectionFillColor = BLUE_COLOR
        imagePicker.settings.theme.selectionStrokeColor = .white
        imagePicker.doneButton.image = UIImage(systemName: "arrow.right")
        imagePicker.doneButton.tintColor = BLUE_COLOR
        imagePicker.cancelButton.image = UIImage(systemName: "xmark")
        imagePicker.cancelButton.tintColor = BLUE_COLOR
        
        self.presentImagePicker(imagePicker, select: { (asset) in
            
        }, deselect: { (asset) in
            
        }, cancel: { (assets) in
            
        }, finish: { (assets) in
            for i in 0..<assets.count {
                let imageManager = PHImageManager.default()
                let option = PHImageRequestOptions()
                option.isSynchronous = true
                
                var thumnail = UIImage()
                
                imageManager.requestImage(for: assets[i], targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFill, options: option) { (result, info) in
                thumnail = result!
                }
                
                let data = thumnail.jpegData(compressionQuality: 0.7)
                self.photos.append(UIImage(data: data!)! as UIImage)
                self.imageCollectionView.reloadData()
            }
        })
    }
}

extension WritingAnswerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageViewCell.identifier, for: indexPath) as? ImageViewCell else {
            return UICollectionViewCell()
        }
        cell.imageView.image = self.photos[indexPath.row]
        cell.xButton.tag = indexPath.row
        cell.xButton.addTarget(self, action: #selector(xButtonImagePressed(sender:)), for: .touchUpInside)
            
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }
    
    @objc private func xButtonImagePressed(sender: UIButton) {
        print("xButtonPressed")
        imageCollectionView.deleteItems(at: [IndexPath.init(row: sender.tag, section: 0)])
        self.photos.remove(at: sender.tag)
    }
}

extension WritingAnswerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 110, height: 110)
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
