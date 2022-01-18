//
//  MemoDetailViewController.swift
//  FinalTest
//
//  Created by 김동우 on 2022/01/01.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class MemoDetailViewController: UIViewController {
    var viewModel: MemoDetailViewModel?
    weak var coordinator: MemoDetailCoordinatorProtocol?
    let disposeBag = DisposeBag()
    
    lazy var foodNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        
        return label
    }()
    
    lazy var regionNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        
        return label
    }()
    
    lazy var calorieLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        
        return label
    }()
    
    lazy var carbohydrateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        
        return label
    }()
    
    lazy var proteinLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        
        return label
    }()
    
    lazy var fatLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        
        return label
    }()
    
    lazy var sugarLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        
        return label
    }()
    
    lazy var sodiumLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        
        return label
    }()
    
    lazy var cholesterolLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        
        return label
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setTitle("추가하기", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.darkGray, for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "음식 추가하기"
        setupViews()
        bind()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        // MARK: 코디네이터 삭제 함수 추가
    }
    
    static func create(with viewModel: MemoDetailViewModel,
                       coordinator: MemoDetailCoordinatorProtocol) -> MemoDetailViewController {
        let view = MemoDetailViewController()
        view.viewModel = viewModel
        view.coordinator = coordinator
        return view
    }
    
    func bind() {
        guard let foodName = viewModel?.result.descKor,
              let regionName = viewModel?.result.samplingRegionName,
              let calorie = viewModel?.result.nutrCont1,
              let carbohydrate = viewModel?.result.nutrCont2,
              let protein = viewModel?.result.nutrCont3,
              let fat = viewModel?.result.nutrCont4,
              let sugar = viewModel?.result.nutrCont5,
              let sodium = viewModel?.result.nutrCont6,
              let cholesterol = viewModel?.result.nutrCont7 else { return }
        foodNameLabel.text = foodName
        regionNameLabel.text = "지역명 : " + regionName
        calorieLabel.text = "칼로리 : " + calorie
        carbohydrateLabel.text = "탄수화물 : " + carbohydrate
        proteinLabel.text = "단백질 : " + protein
        fatLabel.text = "지방 : " + fat
        sugarLabel.text = "당 : " + sugar
        sodiumLabel.text = "소디움? : " + sodium
        cholesterolLabel.text = "콜레스테롤 : " + cholesterol
        
        addButton.rx.tap
            .bind {
                print("추가하기 클릭")
                self.viewModel?.addButtonDidTap()
                self.coordinator?.dismiss()
            }
            .disposed(by: disposeBag)
    }
    
    func setupViews() {
        [ foodNameLabel, regionNameLabel, calorieLabel,
        carbohydrateLabel, proteinLabel, fatLabel,
          sugarLabel, sodiumLabel, cholesterolLabel,
          addButton ].forEach() { view.addSubview($0) }
        
        foodNameLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25).isActive = true
        }
        regionNameLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: foodNameLabel.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35).isActive = true
        }
        calorieLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: regionNameLabel.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35).isActive = true
        }
        carbohydrateLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: calorieLabel.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35).isActive = true
        }
        proteinLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: carbohydrateLabel.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35).isActive = true
        }
        fatLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: proteinLabel.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35).isActive = true
        }
        sugarLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: fatLabel.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35).isActive = true
        }
        sodiumLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: sugarLabel.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35).isActive = true
        }
        cholesterolLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: sodiumLabel.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35).isActive = true
        }
        addButton.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: cholesterolLabel.bottomAnchor, constant: 50).isActive = true
            $0.widthAnchor.constraint(equalToConstant: 100).isActive = true
            $0.heightAnchor.constraint(equalToConstant: 40).isActive = true
            $0.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        }
    }
}

