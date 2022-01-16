//
//  CreateTableViewCell.swift
//  FinalTest
//
//  Created by 김동우 on 2022/01/11.
//

import Foundation
import UIKit
import RxSwift

class CreateTableViewCell: UITableViewCell {
    static let identifier = "CreateTableViewCell"
    var viewModel: CreateTableItemViewModel?
    var disposeBag = DisposeBag()
    
    var foodName: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    var dangLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        subscribe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        [ foodName, dangLabel ].forEach() { self.addSubview($0) }
        
        foodName.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        }
        dangLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: foodName.trailingAnchor, constant: 20).isActive = true
        }
    }
    
    func subscribe() {
        viewModel?.entityItem
            .subscribe(onNext: { entity in
                self.foodName.text = entity.foodName
                self.dangLabel.text = "당: " + entity.dang!
            })
            .disposed(by: disposeBag)
    }
    
    func bind(viewModel: CreateTableItemViewModel) {
        self.viewModel = viewModel
        subscribe()
    }
}
