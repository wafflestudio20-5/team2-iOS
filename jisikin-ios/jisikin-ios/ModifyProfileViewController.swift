//
//  ModifyProfileViewController.swift
//  jisikin-ios
//
//  Created by 김령교 on 2022/12/31.
//

import UIKit

class ModifyProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    lazy var backBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(onTapModifyCancelBtn))
        btn.tintColor = .black
        return btn
    }()
    
    let profilePhotoLabel = UILabel()
    let profilePhotoView = UIImageView()
    let modifyProfilePhotoBtn = UIButton()
    let nickNameLabel = UILabel()
    let modifyNickNameField = UITextField()
    let genderLabel = UILabel()
    let genderSegment = UISegmentedControl(items: ["남", "여"])
    let modifyCancelBtn = UILabel()
    let modifySaveBtn = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        // navigationController?.navigationBar.isHidden = false
        //navigationItem.leftItemsSupplementBackButton = false
        navigationItem.title = "프로필 수정"
        navigationItem.rightBarButtonItem = backBtn
        //navigationController?.navigationBar.leftBarButtonItem = nil
        //navigationController?.navigationBar.rightBarButtonItem = backBtn
        navigationItem.hidesBackButton = true
        
        profilePhotoLabel.text = "프로필 사진"
        
        let profilePhotoSize = CGFloat(45)
//        profilePhotoView.image = UIImage(systemName: "person.fill")!.withTintColor(.white, renderingMode: .alwaysOriginal)
        profilePhotoView.image = UIImage(named:"DefaultProfilePhoto")
        profilePhotoView.backgroundColor = .systemGray
        profilePhotoView.layer.cornerRadius = profilePhotoSize
        profilePhotoView.clipsToBounds = true
        profilePhotoView.layer.borderWidth = 3.0
        profilePhotoView.layer.borderColor = BLUE_COLOR.cgColor
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTapModifyProfilePhotoBtn))
        profilePhotoView.addGestureRecognizer(tapGesture)
        profilePhotoView.isUserInteractionEnabled = true
        
        let smallConfig = UIImage.SymbolConfiguration(pointSize: 23, weight: .regular, scale: .large)
        
        modifyProfilePhotoBtn.setImage(UIImage(systemName:"camera.circle.fill", withConfiguration: smallConfig)!.withTintColor(.black, renderingMode: .alwaysOriginal), for: .normal)
        modifyProfilePhotoBtn.addTarget(self, action: #selector(onTapModifyProfilePhotoBtn), for: .touchUpInside)
        
        
        nickNameLabel.text = "닉네임"
        modifyNickNameField.backgroundColor = .lightGray
        modifyNickNameField.textColor = .white
        modifyNickNameField.text = UserDefaults.standard.string(forKey: "username")
        
        genderLabel.text = "성별"
        
        
        modifyCancelBtn.text = "취소하기"
        modifyCancelBtn.textAlignment = .center
        modifyCancelBtn.layer.borderWidth = 2.0
        modifyCancelBtn.layer.borderColor = UIColor.systemGray.cgColor
        //modifyCancelBtn.layer.cornerRadius = 8
        let tapModifyCancelGesture = UITapGestureRecognizer(target: self, action: #selector(onTapModifyCancelBtn))
        modifyCancelBtn.addGestureRecognizer(tapModifyCancelGesture)
        modifyCancelBtn.isUserInteractionEnabled = true
        
        modifySaveBtn.text = "저장하기"
        modifySaveBtn.textAlignment = .center
        modifySaveBtn.backgroundColor = BLUE_COLOR
        modifySaveBtn.textColor = .white
        //modifySaveBtn.layer.borderWidth = 2.0
        //modifySaveBtn.layer.borderColor = UIColor.systemGray.cgColor
        //modifySaveBtn.layer.cornerRadius = 8
        let tapModifySaveGesture = UITapGestureRecognizer(target: self, action: #selector(onTapModifySaveBtn))
        modifySaveBtn.addGestureRecognizer(tapModifySaveGesture)
        modifySaveBtn.isUserInteractionEnabled = true
        
        view.addSubview(profilePhotoLabel)
        view.addSubview(profilePhotoView)
        view.addSubview(modifyProfilePhotoBtn)
        view.addSubview(nickNameLabel)
        view.addSubview(modifyNickNameField)
        view.addSubview(genderLabel)
        view.addSubview(genderSegment)
        view.addSubview(modifyCancelBtn)
        view.addSubview(modifySaveBtn)
        profilePhotoLabel.translatesAutoresizingMaskIntoConstraints = false
        profilePhotoView.translatesAutoresizingMaskIntoConstraints = false
        modifyProfilePhotoBtn.translatesAutoresizingMaskIntoConstraints = false
        nickNameLabel.translatesAutoresizingMaskIntoConstraints = false
        modifyNickNameField.translatesAutoresizingMaskIntoConstraints = false
        genderLabel.translatesAutoresizingMaskIntoConstraints = false
        genderSegment.translatesAutoresizingMaskIntoConstraints = false
        modifyCancelBtn.translatesAutoresizingMaskIntoConstraints = false
        modifySaveBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profilePhotoLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            profilePhotoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profilePhotoView.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            profilePhotoView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: -profilePhotoSize),
            profilePhotoView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: profilePhotoSize),
            profilePhotoView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 80-profilePhotoSize),//20
            profilePhotoView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 80+profilePhotoSize),//20
            
            modifyProfilePhotoBtn.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor,constant: profilePhotoSize/1.414),
            modifyProfilePhotoBtn.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 80+profilePhotoSize/1.414),//20
            
            
            nickNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            nickNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 165),
            
            modifyNickNameField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            modifyNickNameField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            modifyNickNameField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 195),
            modifyNickNameField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 240),
            
            
            genderLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            genderLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 290),
            
            genderSegment.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            genderSegment.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            genderSegment.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 320),
            genderSegment.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 370),
            
            modifyCancelBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            modifyCancelBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: -10),
            modifyCancelBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            modifyCancelBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            modifySaveBtn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 10),
            modifySaveBtn.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            modifySaveBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            modifySaveBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -10),
        ])
        // Do any additional setup after loading the view.
    }
    func presentCamera(){
            
            let vc = UIImagePickerController()
            vc.sourceType = .camera
            vc.delegate = self
            vc.allowsEditing = true
            vc.cameraFlashMode = .on
            
            present(vc, animated: true, completion: nil)
        }
        
        func presentAlbum(){
            
            
            let vc = UIImagePickerController()
            vc.sourceType = .photoLibrary
            vc.delegate = self
            vc.allowsEditing = true
            
            present(vc, animated: true, completion: nil)
        }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
    //카메라나 앨범등 PickerController가 사용되고 이미지 촬영을 했을 때 발동 된다.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
  
            if let image = info[.editedImage] as? UIImage {
                profilePhotoView.image = image
            }
         dismiss(animated: true, completion: nil)
        
    }
    @objc
    func onTapModifyProfilePhotoBtn() {
        let alert = UIAlertController(title: "선택", message: "이미지를 추가할 방식을 선택하세요", preferredStyle: .actionSheet)
            
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        let camera = UIAlertAction(title: "카메라", style: .default) { [weak self] (_) in
            self?.presentCamera()
        }
        let album = UIAlertAction(title: "앨범", style: .default) { [weak self] (_) in
            self?.presentAlbum()
        }
        
        alert.addAction(cancel)
        alert.addAction(camera)
        alert.addAction(album)
        
        present(alert, animated: true, completion: nil)
    }
    @objc
    func onTapModifyCancelBtn() {
        self.navigationController?.popViewController(animated: true)
    }
    @objc
    func onTapModifySaveBtn() {
        self.navigationController?.popViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
