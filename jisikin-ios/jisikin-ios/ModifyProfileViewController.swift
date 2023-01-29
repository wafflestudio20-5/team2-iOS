//
//  ModifyProfileViewController.swift
//  jisikin-ios
//
//  Created by 김령교 on 2022/12/31.
//

import UIKit
import RxSwift

class ModifyProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    let bag = DisposeBag()
    
    lazy var backBtn: UIBarButtonItem = {
        let btn = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(onTapModifyCancelBtn))
        btn.tintColor = .black
        return btn
    }()
    
    let defaultProfilePhoto = UIImage(named:"DefaultProfilePhoto")
    var profilePhotoIsModified = false
    
    let profilePhotoLabel = UILabel()
    let profilePhotoView = UIImageView()
    let modifyProfilePhotoBtn = UIButton()
    let nickNameLabel = UILabel()
    let modifyNickNameField = TextFieldWithPadding()
    let nickNameCriteriaLabel = UILabel()
    let genderLabel = UILabel()
    let genderSegment = UISegmentedControl(items: ["남", "여"])
    let modifyCancelBtn = UILabel()
    let modifySaveBtn = UILabel()
    
    let viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewLoad()
    }
    
    func viewLoad(){
        self.view.backgroundColor = .white
        
        navigationItem.title = "프로필 수정"
        navigationItem.rightBarButtonItem = backBtn
        navigationItem.hidesBackButton = true
        
        profilePhotoLabel.text = "프로필 사진"
        
        let profilePhotoSize = CGFloat(45)
//        profilePhotoView.image = UIImage(named:"DefaultProfilePhoto")
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
        nickNameCriteriaLabel.textColor = .red
        nickNameCriteriaLabel.font = UIFont.systemFont(ofSize: 12)
        
        genderLabel.text = "성별"
        viewModel.getProfile()
        viewModel.profile.subscribe(onNext: {[weak self]
            profile in
            if self==nil{return}
            if let profile{
                profile.profileImage.subscribe(onNext:{[weak self] image in
                    if let self = self{
                        if let profileImage = image{
                            if !self.profilePhotoIsModified{
                                self.profilePhotoView.image = profileImage
                            }
                        }else{
                            if let data = UserDefaults.standard.data(forKey: "profileImage"){
                                self.profilePhotoView.image = UIImage(data: data)
                            }else{
                                self.profilePhotoView.image = UIImage(named:"DefaultProfilePhoto")
                            }
                        }
                    }
                })
                self!.modifyNickNameField.text = profile.username
                if profile.isMale!{
                    self!.genderSegment.selectedSegmentIndex = 0
                }else{
                    self!.genderSegment.selectedSegmentIndex = 1
                }
            }
        }).disposed(by: bag)
        
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
        let tapModifySaveGesture = UITapGestureRecognizer(target: self, action: #selector(onTapModifySaveBtn))
        modifySaveBtn.addGestureRecognizer(tapModifySaveGesture)
        modifySaveBtn.isUserInteractionEnabled = true
        
        view.addSubview(profilePhotoLabel)
        view.addSubview(profilePhotoView)
        view.addSubview(modifyProfilePhotoBtn)
        view.addSubview(nickNameLabel)
        view.addSubview(modifyNickNameField)
        view.addSubview(nickNameCriteriaLabel)
        view.addSubview(genderLabel)
        view.addSubview(genderSegment)
        view.addSubview(modifyCancelBtn)
        view.addSubview(modifySaveBtn)
        profilePhotoLabel.translatesAutoresizingMaskIntoConstraints = false
        profilePhotoView.translatesAutoresizingMaskIntoConstraints = false
        modifyProfilePhotoBtn.translatesAutoresizingMaskIntoConstraints = false
        nickNameLabel.translatesAutoresizingMaskIntoConstraints = false
        modifyNickNameField.translatesAutoresizingMaskIntoConstraints = false
        nickNameCriteriaLabel.translatesAutoresizingMaskIntoConstraints = false
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
            profilePhotoView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 80-profilePhotoSize),
            profilePhotoView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 80+profilePhotoSize),
            
            modifyProfilePhotoBtn.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor,constant: profilePhotoSize/1.414),
            modifyProfilePhotoBtn.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 80+profilePhotoSize/1.414),
            
            
            nickNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            nickNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 165),
            
            modifyNickNameField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            modifyNickNameField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            modifyNickNameField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 195),
            modifyNickNameField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 240),
            
            nickNameCriteriaLabel.topAnchor.constraint(equalTo: modifyNickNameField.bottomAnchor, constant:  5),
            nickNameCriteriaLabel.leadingAnchor.constraint(equalTo: modifyNickNameField.leadingAnchor),
            
            
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
                profilePhotoIsModified = true
                //profilePhotoIsExisted = true
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
        var isMale: Bool
        
        if genderSegment.selectedSegmentIndex == 0{isMale = true}
        else{isMale = false}
        
        if profilePhotoIsModified{
            viewModel.modifyProfile(profileImage: profilePhotoView.image, username: modifyNickNameField.text!, isMale: isMale){ [self] error in
                if !error.usernameExists{
                    if viewModel.usecase.profile.value?.profileImage != ""{
                        print("image must be deleted")
                        if let url = viewModel.usecase.profile.value?.profileImage{
                            viewModel.deleteProfileImage(url: url)
                        }
                        
                    }
                    self.success()
                }else{
                    self.nickNameCriteriaLabel.text = "중복된 닉네임입니다."
                }
            }
        }else{
            viewModel.modifyProfile(profileImage: nil, username: modifyNickNameField.text!, isMale: isMale){error in
                if !error.usernameExists{
                    self.success()
                }else{
                    self.nickNameCriteriaLabel.text = "중복된 닉네임입니다."
                }
            }
        }
    }
    
    func success(){
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
