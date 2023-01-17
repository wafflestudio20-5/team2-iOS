//
//  ImageViewCell.swift
//  jisikin-ios
//
//  Created by 홍희주 on 2023/01/18.
//

import UIKit

class ImageViewCell: UICollectionViewCell {
    
    static let identifier = "ImageViewCell"
    
    private let cellHeight: CGFloat = 100
   
    lazy var imageView: UIImageView = {
        var image = UIImageView()
        image.backgroundColor = .white
        return image
    }()
    
    lazy var xButton: UIButton = {
        var button = UIButton()
        button.setImage(systemName: "x.circle", color: UIColor.lightGray)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
        setConstraints()
    }
    
    private func setUI() {
        self.addSubview(imageView)
        self.addSubview(xButton)
    }
    
    private func setConstraints() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        xButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: cellHeight),
            imageView.widthAnchor.constraint(equalToConstant: cellHeight),
            imageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            xButton.centerXAnchor.constraint(equalTo: imageView.rightAnchor),
            xButton.heightAnchor.constraint(equalToConstant: 20),
            xButton.widthAnchor.constraint(equalToConstant: 20),
            xButton.centerYAnchor.constraint(equalTo: imageView.topAnchor)
        ])
    }
}
