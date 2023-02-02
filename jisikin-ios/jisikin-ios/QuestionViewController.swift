//
//  QuestionViewController.swift
//  jisikin-ios
//
//  Created by 김령교 on 2022/12/27.
//

import UIKit
import Photos
import BSImagePicker

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
    
    var questionID: Int = -1
    
    var isEdit: Bool = false
    
    var viewModel = QuestionListViewModel(usecase:QuestionAnswerUsecase())
    var questionTitle:String? = ""
    var questionContent:String? = ""
    var tags: [String] = []
    
    var photos: [UIImage] = []
    
    var cnt: Int = 0
    
    var onEdit:(()->())?
    
    var tagCollectionView: UICollectionView = {
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
    
    let textViewPlaceHolder = "무엇이 궁금한가요?"
    
    lazy var accessoryView: UIView = {
        return UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 75))
    }()
    
    lazy var titleField: UITextField = {
        let field = UITextField()
        
        field.borderStyle = .none
        field.placeholder = "제목"
        field.font = .systemFont(ofSize: 23)
        field.setPlaceHolderColor(UIColor.lightGray)
        field.backgroundColor = UIColor.white
        field.delegate = self
        field.inputAccessoryView = accessoryView
        
        return field
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
        if isEdit {
            titleField.text = questionTitle
            contentView.text = questionContent
            contentView.textColor = .black
        }

        setNavigationBar()
        tagCollectionView.dataSource = self
        tagCollectionView.delegate = self
        imageCollectionView.dataSource = self
        imageCollectionView.delegate = self
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contentView.becomeFirstResponder()

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
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "QuestionLogo")
        imageView.image = image
        navigationItem.titleView = imageView
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
        self.navigationController?.isNavigationBarHidden = false
       
    }
    
    private func setLayout() {
        view.addSubview(titleField)
        view.addSubview(topLineView)
        view.addSubview(contentView)
        accessoryView.addSubview(plusImageButton)
        accessoryView.addSubview(lineView)
        accessoryView.addSubview(tagCollectionView)
        accessoryView.addSubview(addTagButton)
        // accessoryView.addSubview(imageCollectionView)
        view.addSubview(imageCollectionView)
        
        guard let lineSuperView = lineView.superview else { return }
        
        titleField.translatesAutoresizingMaskIntoConstraints = false
        topLineView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        plusImageButton.translatesAutoresizingMaskIntoConstraints = false
        addTagButton.translatesAutoresizingMaskIntoConstraints = false
        lineView.translatesAutoresizingMaskIntoConstraints = false
        tagCollectionView.translatesAutoresizingMaskIntoConstraints = false
        imageCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
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
            contentView.heightAnchor.constraint(equalToConstant: 170),
            
            plusImageButton.heightAnchor.constraint(equalToConstant: 38),
            plusImageButton.widthAnchor.constraint(equalToConstant: 38),
            plusImageButton.leftAnchor.constraint(equalTo: lineSuperView.leftAnchor, constant: 5),
            plusImageButton.bottomAnchor.constraint(equalTo: lineSuperView.bottomAnchor, constant: -1),
            
            lineView.bottomAnchor.constraint(equalTo: plusImageButton.topAnchor, constant: -1),
            lineView.widthAnchor.constraint(equalTo: lineSuperView.widthAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1),
            lineView.centerXAnchor.constraint(equalTo: lineSuperView.centerXAnchor),
            
            tagCollectionView.leftAnchor.constraint(equalTo: addTagButton.rightAnchor, constant: 10),
            tagCollectionView.rightAnchor.constraint(equalTo: lineSuperView.rightAnchor),
            tagCollectionView.bottomAnchor.constraint(equalTo: plusImageButton.topAnchor, constant: -10),
            tagCollectionView.heightAnchor.constraint(equalToConstant: 22),
            
            addTagButton.heightAnchor.constraint(equalToConstant: 20),
            addTagButton.leftAnchor.constraint(equalTo: lineSuperView.leftAnchor, constant: 10),
            addTagButton.widthAnchor.constraint(equalToConstant: 20),
            addTagButton.bottomAnchor.constraint(equalTo: tagCollectionView.bottomAnchor),
            /*
            imageCollectionView.leftAnchor.constraint(equalTo: lineSuperView.leftAnchor, constant: 10),
            imageCollectionView.rightAnchor.constraint(equalTo: lineSuperView.rightAnchor),
            imageCollectionView.heightAnchor.constraint(equalToConstant: 120),
            imageCollectionView.bottomAnchor.constraint(equalTo: tagCollectionView.topAnchor, constant: -3)
             */
            imageCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageCollectionView.topAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5),
            imageCollectionView.heightAnchor.constraint(equalToConstant: 120)
        ])
    }
    
    @objc private func doneQuestion(_ sender: Any) {
        if (titleField.text ?? "").count < 1 {
            let alert = UIAlertController(title: "주의", message: "제목을 입력하세요.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
        } else if (contentView.text == textViewPlaceHolder) {
            let alert = UIAlertController(title: "주의", message: "내용을 입력하세요.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            
            self.present(alert, animated: true, completion: nil)
        } else {
            guard let titleText = titleField.text else { return }
            guard let contentText = contentView.text else { return }
            
            if isEdit == false {
                viewModel.postNewQuestion(titleText: titleText, contentText: contentText, tag: self.tags, photos: self.photos)
            } else {
                // 수정할 때
                viewModel.editQuestion(questionID: self.questionID, titleText: titleText, contentText: contentText, tag: self.tags, photos: self.photos){
                    result in
                    if result == "success"{
                        self.onEdit?()
                        self.navigationController?.popViewController(animated: false)
                       
                    }
                }
            }
        }
        
        view.endEditing(true)
        navigationController?.popViewController(animated: false)
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
    
    @objc private func leftButton(_ sender: Any) {
        view.endEditing(true)
        navigationController?.popViewController(animated: false)
    }
    
    @objc private func addTag(_ sender: Any) {
        let controller = UIAlertController(title: nil, message: "태그를 입력하세요", preferredStyle: .alert)
        controller.addTextField { field in
            field.placeholder = "최대 20자까지 입력"
        }
        
        let okAction = UIAlertAction(title: "추가", style: .default) { action in
            if (controller.textFields?.first!.text ?? "").count < 1 {
                return
            } // 20자 이상일 때도 alert 띄우기
            if (controller.textFields?.first!.text ?? "").count > 20 {
                let alert = UIAlertController(title: "주의", message: "태그는 20자를 넘을 수 없습니다", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(action)
                
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            guard let tag = controller.textFields?.first!.text else { return }
            self.tags.append(tag)
            self.tagCollectionView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .default)
        
        controller.addAction(okAction)
        controller.addAction(cancelAction)
        
        present(controller, animated: true, completion: nil)
    }
}

extension QuestionViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
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
                
                imageManager.requestImage(for: assets[i], targetSize: CGSize(width: 360, height: 360), contentMode: .aspectFill, options: option) { (result, info) in
                    thumnail = result!
                    print(thumnail.size.width, thumnail.size.height)
                }
                
                let data = thumnail.jpegData(compressionQuality: 1)
                self.photos.append(UIImage(data: data!)! as UIImage)
                self.imageCollectionView.reloadData()
            }
        })
    }
}

extension QuestionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == tagCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: tagViewCell.identifier, for: indexPath) as? tagViewCell else {
                return UICollectionViewCell()
            }
            cell.tagLabel.text = "#" + self.tags[indexPath.row]
            cell.xButton.tag = indexPath.row
            cell.xButton.addTarget(self, action: #selector(xButtonPressed(sender:)), for: .touchUpInside)
            
            return cell
        }
        else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageViewCell.identifier, for: indexPath) as? ImageViewCell else {
                return UICollectionViewCell()
            }
            cell.imageView.image = self.photos[indexPath.row]
            cell.xButton.tag = indexPath.row
            cell.xButton.addTarget(self, action: #selector(xButtonImagePressed(sender:)), for: .touchUpInside)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == tagCollectionView {
            return self.tags.count
        }
        else {
            return self.photos.count
        }
    }
    
    @objc private func xButtonPressed(sender: UIButton) {
        tagCollectionView.deleteItems(at: [IndexPath.init(row: sender.tag, section: 0)])
        tags.remove(at: sender.tag)
    }
    
    @objc private func xButtonImagePressed(sender: UIButton) {
        imageCollectionView.deleteItems(at: [IndexPath.init(row: sender.tag, section: 0)])
        photos.remove(at: sender.tag)
    }
}

extension QuestionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == tagCollectionView {
            let label = UILabel()
            label.text = "#" + self.tags[indexPath.row]
            label.font = .systemFont(ofSize: 18)
            label.sizeToFit()
            let cellWidth = label.frame.width + 22
            
            return CGSize(width: cellWidth, height: 22)
        }
        else {
            return CGSize(width: 110, height: 110)
        }
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
