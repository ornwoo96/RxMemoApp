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
    var navigationController = UINavigationController()
    var viewController: viewControllerProtocol?
    var presentingViewController: viewControllerProtocol?
    
    init(presentingViewController: viewControllerProtocol) {
        self.presentingViewController = presentingViewController
    }
    
    func start() {
        let memoListDIContainer = MemoListDIContainer()
        let actions = MemoListViewModelActions(showMemoDetailView: showMemoDetailView)
        let viewController = memoListDIContainer.makeMemoListViewController(actions: actions)
        viewController.coordinator = self
        parentsCoordinator?.viewController = viewController
        parentsCoordinator?.childCoordinators.append(self)
        guard let presentingView = presentingViewController as? UIViewController else { return }
        let memoListView = UINavigationController(rootViewController: viewController)
        presentingView.present(memoListView, animated: true)
        presentingViewController = viewController
        self.navigationController = memoListView
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
}
