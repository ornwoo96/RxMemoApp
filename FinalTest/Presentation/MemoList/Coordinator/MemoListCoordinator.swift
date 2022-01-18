//
//  MemoListCoordinator.swift
//  FinalTest
//
//  Created by 김동우 on 2021/12/29.
//

import UIKit

protocol MemoListCoordinatorProtocol: Coordinator {
    func showMemoDetailView(resultData: Result)
}

class MemoListCoordinator: MemoListCoordinatorProtocol {
    weak var parentsCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController = UINavigationController()
    var viewController: MemoListParentable? // MARK: ParentView에 func을 사용하기 위해
    let memoListDIContainer = MemoListDIContainer()
    
    init(viewController: MemoListParentable) {
        self.viewController = viewController
    }
    
    func start() {
        guard let viewController = memoListDIContainer.makeMemoListViewController(coordinator: self) as? UIViewController & MemoListParentable else { return }
        self.navigationController = UINavigationController(rootViewController: viewController)
        self.navigationController.pushViewController(viewController, animated: true)
        self.viewController = viewController
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func showMemoDetailView(resultData: Result) {
        guard let viewController = self.viewController else { return }
        let memoDetailCoordinator = MemoDetailCoordinator(result: resultData,
                                                          navigationController: self.navigationController,
                                                          viewController: viewController)
        memoDetailCoordinator.parentsCoordinator = self
        childCoordinators.append(memoDetailCoordinator)
        memoDetailCoordinator.start()
    }
}
