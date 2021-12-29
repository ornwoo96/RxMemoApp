//
//  MemoListCollectionViewCell.swift
//  testApp
//
//  Created by 김동우 on 2021/12/29.
//

import UIKit

class MemoListCollectionViewCell: UICollectionViewCell {
    static let identifier = "MemoListCollectionViewCell"
    
    var titleLabel = UILabel()
    var contentLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        configureTitleLabel()
        configureContentLabel()
    }
    
    func configureTitleLabel() {
        self.addSubview(titleLabel)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        titleLabel.text = "dd"
        titleLabel.textColor = .black
    }
    
    func configureContentLabel() {
        self.addSubview(contentLabel)
        contentLabel.font = UIFont.boldSystemFont(ofSize: 15)
        contentLabel.textColor = .black
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        contentLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40).isActive = true
    }
}
