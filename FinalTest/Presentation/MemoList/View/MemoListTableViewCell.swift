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

class MemoListTableViewCell: UITableViewCell {
    static let identifier = "MemoListTableViewCell"
    
    let disposeBag = DisposeBag()
    
    // MARK: 여기서 쓰이는게 아닐듯?
    var viewModel = PublishSubject<ResultViewModel>()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.do {
            $0.font = UIFont.boldSystemFont(ofSize: 17)
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
                self.contentLabel.text = "당: \(resultViewModel.sugar ?? "")"
            })
            .disposed(by: disposeBag)
    }
    
    func configureUI() {
        [ titleLabel, contentLabel ].forEach() { addSubview($0) }
        
        titleLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        }
        contentLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: self.titleLabel.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 10).isActive = true
        }
    }
}
