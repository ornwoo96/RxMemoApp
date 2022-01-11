//
//  ViewController.swift
//  FinalTest
//
//  Created by 김동우 on 2021/12/29.
//

import UIKit
import RxSwift
import RxCocoa
import Then

// MARK: async await 공부

class MemoListViewController: UIViewController, viewControllerProtocol {
    var coordinator: MemoListCoordinator?
    var viewModel: MemoListViewModel?
    var disposeBag = DisposeBag()
    var memoTableView = UITableView()
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "김치찌개, 냉면..."
        
        return searchBar
    }()
    
    static func create(with viewModel: MemoListViewModel) -> MemoListViewController {
        let view = MemoListViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = "음식 검색"
        setupViews()
        bind()
        searchBar.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        coordinator?.childDidFinish(coordinator)
    }
    
    func setupViews() {
        [ memoTableView, searchBar ].forEach() { view.addSubview($0) }
        
        memoTableView.do {
            $0.dataSource = self
            $0.delegate = self
            $0.register(MemoListTableViewCell.self, forCellReuseIdentifier: "MemoListTableViewCell")
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            $0.backgroundColor = .white
        }
        searchBar.do {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
    }
    
    func bind() {
        // MARK: ReloadData를 사용하고 싶어서 만든 옵저버이다! resultViewModel을 subscribe하면 되지 굳이?
        self.viewModel?.resultViewModel
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { result in
                self.memoTableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}

extension MemoListViewController: UISearchBarDelegate {
    @objc func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel?.fetchResult(query: "\(searchBar.text ?? "")")
    }
}

extension MemoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension MemoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.resultViewModel.value.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = memoTableView.dequeueReusableCell(withIdentifier: "MemoListTableViewCell", for: indexPath) as! MemoListTableViewCell
        if let resultViewModel = viewModel?.resultViewModel.value[indexPath.row] {
            cell.viewModel.onNext(resultViewModel)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedResult = viewModel?.result[indexPath.row] {
            viewModel?.showMemoDetailView(result: selectedResult)
        }
    }
}
