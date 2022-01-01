//
//  MemoListCollectionViewCell.swift
//  testApp
//
//  Created by 김동우 on 2021/12/29.
//

import UIKit
import RxSwift
import Then
import Alamofire

class MemoListCollectionViewCell: UICollectionViewCell {
    static let identifier = "MemoListCollectionViewCell"
    
    let disposeBag = DisposeBag()
    var viewModel = PublishSubject<ResultViewModel>()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.do {
            $0.font = UIFont.boldSystemFont(ofSize: 20)
            $0.textColor = .black
            $0.text = "dd"
            $0.textColor = .black
        }
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.do {
            $0.font = UIFont.boldSystemFont(ofSize: 15)
            $0.textColor = .black
        }
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        subscribe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func subscribe() {
        self.viewModel
            .subscribe(onNext: { resultViewModel in
                self.titleLabel.text = resultViewModel.foodName
                self.contentLabel.text = resultViewModel.sugar
            })
            .disposed(by: disposeBag)
    }
    
    func configureUI() {
        [ titleLabel, contentLabel ].forEach() { addSubview($0) }
        
        titleLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        }
        contentLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40).isActive = true
        }
    }
}
