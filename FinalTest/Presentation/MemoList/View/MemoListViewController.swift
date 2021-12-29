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

class MemoListViewController: UIViewController {
    weak var coordinator: MemoListCoordinator?
    var viewModel: MemoListViewModel!
    var disposeBag = DisposeBag()
    
    var tempMemoData: [String] = [
        "바보", "바보", "바보", "바보","바보", "바보","바보", "바보","바보", "바보","바보", "바보",
        "바보", "바보", "바보", "바보","바보", "바보","바보", "바보","바보", "바보","바보", "바보"
    ]
    
    var memoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.maxX,
                                 height: UIScreen.main.bounds.maxX/7)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView
    }()
    
    lazy var createButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "plus"),
                                     style: .plain,
                                     target: self,
                                     action: #selector(createButtonDidTap(sender:)))
        
        return button
    }()
    
    static func create(with viewModel: MemoListViewModel) -> MemoListViewController {
        let view = MemoListViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coordinator?.childDidFinish()
        view.backgroundColor = .white
        setupViews()
        self.bind(viewModel: self.viewModel)
    }
    
    private func bind(viewModel: MemoListViewModel) {
//        self.viewModel.
    }
    
    func setupViews() {
        configureNavigationBar()
        configureMemoCollectionView()
    }
    
    func configureNavigationBar() {
        navigationController?.do {
            $0.navigationBar.prefersLargeTitles = true
            $0.navigationBar.topItem?.title = "MemoList"
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(createButtonDidTap(sender:))
        )
    }
    
    func configureMemoCollectionView() {
        view.addSubview(memoCollectionView)
        memoCollectionView.do {
            $0.register(MemoListCollectionViewCell.self, forCellWithReuseIdentifier: "MemoListCollectionViewCell")
            $0.dataSource = self
            $0.delegate = self
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            $0.backgroundColor = .white
        }
    }
}

extension MemoListViewController {
    @objc func createButtonDidTap(sender: UIBarButtonItem) {
        print("버튼눌림")
    }
}

extension MemoListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tempMemoData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = memoCollectionView.dequeueReusableCell(withReuseIdentifier: "MemoListCollectionViewCell", for: indexPath) as! MemoListCollectionViewCell
        
        cell.titleLabel.text = tempMemoData[indexPath.item]
        cell.contentLabel.text = tempMemoData[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        <#code#>
    }
}

extension MemoListViewController: UICollectionViewDelegateFlowLayout {
    
}
