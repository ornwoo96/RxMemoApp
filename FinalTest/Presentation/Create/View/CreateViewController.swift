//
//  CreateViewController.swift
//  FinalTest
//
//  Created by 김동우 on 2022/01/10.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class CreateViewController: UIViewController, viewControllerProtocol {
    private var viewModel: CreateViewModel?
    var coordinator: Coordinator?
    var disposeBag = DisposeBag()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.do {
            $0.textColor = .black
            $0.font = UIFont.boldSystemFont(ofSize: 20)
            $0.text = "Bind를 써보고 싶어서..."
        }
        return label
    }()
    var sortLabel: UILabel = {
        let label = UILabel()
        label.do {
            $0.textColor = .black
            $0.font = UIFont.systemFont(ofSize: 18)
            $0.text = "정렬 기준"
        }
        return label
    }()
    var optionSortNewest: UIButton = {
        let button = UIButton()
        button.do {
            $0.titleLabel?.text = "최신순"
            $0.backgroundColor = .blue
        }
        return button
    }()
    var optionSortOlest: UIButton = {
        let button = UIButton()
        
        return button
    }()
    var termLabel: UILabel = {
        let label = UILabel()
        label.do {
            $0.textColor = .black
            $0.font = UIFont.systemFont(ofSize: 18)
            $0.text = "기간 설정"
        }
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        bind()
    }
    
    static func create(with viewModel: CreateViewModel) -> CreateViewController{
        let view = CreateViewController()
        view.viewModel = viewModel
        return view
    }
    
    func setupUI() {
        [ titleLabel, sortLabel, optionSortNewest, optionSortOlest, termLabel ].forEach() { view.addSubview($0) }
        
        titleLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        }
        sortLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        }
        optionSortNewest.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.widthAnchor.constraint(equalToConstant: 100).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
            $0.topAnchor.constraint(equalTo: sortLabel.bottomAnchor, constant: 20).isActive = true
        }
        optionSortOlest.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        termLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: optionSortNewest.bottomAnchor, constant: 20).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        }
    }
    
    func bind() {
        optionSortNewest.rx.tap
            .bind {
                print("최신순 클릭됨")
            }
            .disposed(by: disposeBag)
        
        
    }
}

extension CreateViewController {
    
}
