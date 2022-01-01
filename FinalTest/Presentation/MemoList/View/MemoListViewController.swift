//
//  ViewController.swift
//  FinalTest
//
//  Created by 김동우 on 2021/12/29.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa
import Then

class MemoListViewController: UIViewController {
    weak var coordinator: MemoListCoordinator?
    var viewModel: MemoListViewModel!
    var disposeBag = DisposeBag()
    
    // BehaviorRelay로 ResultViewModel을 생성해놓고
    private let resultViewModel = BehaviorRelay<[ResultViewModel]>(value: [])
    
    // Observable로 위에 생성해놓은 BehaviorRelay<[ResultViewModel]> 타입의 배열에 데이터가 바뀔떄마다
    // 감시하다가 Subscriber에게 알려줌!
    var resultViewModelObserver: Observable<[ResultViewModel]> {
        return resultViewModel.asObservable()
    }
    
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
        feachResult()
        subscribe()
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
            $0.dataSource = self
            $0.delegate = self
            $0.register(MemoListCollectionViewCell.self, forCellWithReuseIdentifier: "MemoListCollectionViewCell")
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            $0.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            $0.backgroundColor = .white
        }
    }
    
    func feachResult() {
        viewModel
            .fetchResult()
            .subscribe(onNext: { resultViewModels in
                // resultViewModel에 담기
                self.resultViewModel.accept(resultViewModels)
            })
            .disposed(by: disposeBag)
    }
    
    func subscribe() {
        // resultViewModel에 데이터가 바뀔때마다 reloadData!
        self.resultViewModelObserver
            .subscribe(onNext: { results in
                DispatchQueue.main.async {
                    self.memoCollectionView.reloadData()
                }
            })
            .disposed(by: disposeBag)
    }
}

extension MemoListViewController {
    @objc func createButtonDidTap(sender: UIBarButtonItem) {
        print("버튼눌림")
    }
}

extension MemoListViewController: UICollectionViewDelegate {
    
}

extension MemoListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.resultViewModel.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = memoCollectionView.dequeueReusableCell(withReuseIdentifier: "MemoListCollectionViewCell", for: indexPath) as! MemoListCollectionViewCell
        
        let resultViewModel = self.resultViewModel.value[indexPath.row]
        
        cell.viewModel.onNext(resultViewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        <#code#>
    }
}

extension MemoListViewController: UICollectionViewDelegateFlowLayout {
    
}
