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
    var coordinator: MemoListCoordinator?
    var viewModel: MemoListViewModel!
    var disposeBag = DisposeBag()
    
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
        view.backgroundColor = .white
        setupViews()
        self.bind(viewModel: self.viewModel)
        feachResult()
        subscribe()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
//        coordinator?.childDidFinish()
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
            .subscribe(onNext: { [weak self] resultViewModels in
                // resultViewModel에 담기
                self?.viewModel.resultViewModel.accept(resultViewModels)
            })
            .disposed(by: disposeBag)
    }
    
    func subscribe() {
        // resultViewModel에 데이터가 바뀔때마다 reloadData!
        self.viewModel.resultViewModelObserver
            .subscribe(onNext: { [weak self] results in
                DispatchQueue.main.async {
                    self?.memoCollectionView.reloadData()
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
        return viewModel.resultViewModel.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = memoCollectionView.dequeueReusableCell(withReuseIdentifier: "MemoListCollectionViewCell", for: indexPath) as! MemoListCollectionViewCell
        
        let resultViewModel = viewModel.resultViewModel.value[indexPath.row]
        
        cell.viewModel.onNext(resultViewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let result = self.resultViewModel[indexPath.row]
//        coordinator?.showMemoDetailView(resultData: result)
        print("didSelected")
        coordinator?.showMemoDetailView(resultData: viewModel.fetchResultData()[indexPath.row])
    }
}

extension MemoListViewController: UICollectionViewDelegateFlowLayout {
    
}



//// MARK: 뷰모델1의 특정 메소드를 뷰모델2에서 실행할 수 있게
//
//class ParentCoordinator {
//    func start() {
//        let viewModel = ParentViewModel()
//
//        let view2Coordinator = ChildCoordinator(parentFunc: viewModel.parentFunc)
//
//        let view2ViewController = view2Coordinator.makeView2Controller()
//
//        ParentViewController(view2Controller: view2ViewController, viewModel: viewModel)
//    }
//}
//
//class ParentViewController {
//    var viewModel: ParentViewModel
//
//    var view2Controller: ChildViewController
//
//    init(view2Controller: ChildViewController, viewModel: ParentViewModel) {
//        self.viewModel = viewModel
//        self.view2Controller = view2Controller
//    }
//}
//
//class ParentViewModel {
//    func parentFunc() {
//        print("목표 메소드")
//    }
//}
//
//
////----------------------------------------
//
//
//class ChildCoordinator {
//    var parentFunc: () -> Void
//
//    init(parentFunc: @escaping () -> Void) {
//        self.parentFunc = parentFunc
//    }
//
//    func makeView2Controller() -> ChildViewController {
//        let viewModel = ChildViewModel(parentFunc: parentFunc)
//
//        return ChildViewController(viewModel: viewModel)
//    }
//}
//
//class ChildViewController {
//    var viewModel: ChildViewModel
//
//    init(viewModel: ChildViewModel) {
//        self.viewModel = viewModel
//    }
//}
//
//class ChildViewModel {
//
//    var parentFunc: () -> Void
//
//    init(parentFunc: @escaping () -> Void) {
//        self.parentFunc = parentFunc
//    }
//
//    func specificTiming() {
//        parentFunc() // == 부모뷰모델.parentFunc
//    }
//}
