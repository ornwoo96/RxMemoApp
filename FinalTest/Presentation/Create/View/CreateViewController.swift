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
    
    var dangLabel: UILabel = {
        let label = UILabel()
        label.do {
            $0.font = UIFont.boldSystemFont(ofSize: 15)
            $0.textColor = .black
        }
        return label
    }()
    var foodsTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configure()
        setupUI()
        configureNavigationBar()
        bind()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        coordinator?.childDidFinish(coordinator)
    }
    
    static func create(with viewModel: CreateViewModel) -> CreateViewController{
        let view = CreateViewController()
        view.viewModel = viewModel
        return view
    }
    
    func configure() {
        foodsTableView.do {
            $0.register(CreateTableViewCell.self, forCellReuseIdentifier: "CreateTableViewCell")
            $0.delegate = self
            $0.dataSource = self
        }
    }
    
    func setupUI() {
        [ dangLabel, foodsTableView ].forEach() { view.addSubview($0) }
        
        dangLabel.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        }
        foodsTableView.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: dangLabel.bottomAnchor, constant: 10).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
    }
    
    func configureNavigationBar() {
        navigationController?.do {
            $0.navigationBar.topItem?.title = "Food eaten Today"
            $0.navigationBar.prefersLargeTitles = true
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(createButtonDidTap(sender:))
        )
    }
    
    func bind() {
        
    }
}

extension CreateViewController {
    @objc func createButtonDidTap(sender: UIBarButtonItem) {
        viewModel?.createButtonDidTap()
    }
}

extension CreateViewController: UITableViewDelegate {
    
}

extension CreateViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CreateTableViewCell", for: indexPath) as? CreateTableViewCell else { return defaultCell }
        
        
        return cell
    }
    
    
}
