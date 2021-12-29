//
//  MemoListCoordinator.swift
//  FinalTest
//
//  Created by 김동우 on 2021/12/29.
//

import UIKit

class MemoListCoordinator: Coordinator {
    weak var parentsCoordinator: MainCoordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    //
    func start() {
        let memoListDIContainer = MemoListDIContainer()
        let viewController = memoListDIContainer.makeMemoListViewController()
        viewController.coordinator = self
        self.navigationController.pushViewController(viewController, animated: false)
    }
    
    func childDidFinish() {
        parentsCoordinator?.childDidFinish(self)
    }
    
//    func showMemoDetailView() {
//        let memoDetailCoordinator = MemoDetailCoordinator(navigationController: navigationController)
//        memoDetailCoordinator.start()
//    }
}
