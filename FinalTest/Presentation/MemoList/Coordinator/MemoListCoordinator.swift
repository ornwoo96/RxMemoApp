//
//  MemoListCoordinator.swift
//  FinalTest
//
//  Created by 김동우 on 2021/12/29.
//

import UIKit

class MemoListCoordinator: Coordinator {
    weak var parentsCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var viewController: viewControllerProtocol?
    var presentingViewController: viewControllerProtocol?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let memoListDIContainer = MemoListDIContainer()
        let actions = MemoListViewModelActions(showMemoDetailView: showMemoDetailView,
                                               showCreateView: showCreateView)
        let viewController = memoListDIContainer.makeMemoListViewController(actions: actions)
        viewController.coordinator = self
        parentsCoordinator?.viewController = viewController
        parentsCoordinator?.childCoordinators.append(self)
        self.navigationController.pushViewController(viewController, animated: false)
        presentingViewController = viewController
        
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
        let memoDetailCoordinator = MemoDetailCoordinator(result: resultData, navigationController: navigationController)
        memoDetailCoordinator.parentsCoordinator = self
        self.childCoordinators.append(memoDetailCoordinator)
        memoDetailCoordinator.start()
    }
    
    func showCreateView() {
        guard let presentView = presentingViewController else { return }
        let createCoordinator = CreateCoordinator(navigationController: navigationController,
                                                  presentingViewController: presentView)
        createCoordinator.parentsCoordinator = self
        self.childCoordinators.append(createCoordinator)
        createCoordinator.start()
    }
}
