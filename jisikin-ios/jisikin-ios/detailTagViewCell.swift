//
//  detailTagViewCell.swift
//  jisikin-ios
//
//  Created by 박정헌 on 2023/01/21.
//

import Foundation
import UIKit

class DetailTagViewCell: UICollectionViewCell {
    
    static let identifier = "detailTagViewCell"
    
    private let cellHeight: CGFloat = 22
    
    lazy var tagLabel: UILabel = {
        var label = UILabel()
        label.backgroundColor = UIColor.systemGray6
        label.textColor = UIColor.blue
        label.font = .systemFont(ofSize: 18)
        label.sizeToFit()
        // label.text
        return label
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
        self.addSubview(tagLabel)
      //  self.addSubview(xButton)
    }
    
    private func setConstraints() {
        tagLabel.translatesAutoresizingMaskIntoConstraints = false
       // xButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tagLabel.heightAnchor.constraint(equalToConstant: cellHeight),
            tagLabel.leftAnchor.constraint(equalTo: self.leftAnchor),
            tagLabel.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
    }
}
