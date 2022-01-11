//
//  CreateCoordinator.swift
//  FinalTest
//
//  Created by 김동우 on 2022/01/10.
//

import Foundation
import UIKit

class CreateCoordinator: Coordinator {
    weak var parentsCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var viewController: viewControllerProtocol?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let diContainer = CreateDIContainer()
        let actions = CreateViewModelAction(createButtonDidTap: showMemoListViewController)
        let viewController = diContainer.makeCreateViewController(actions: actions)
        viewController.coordinator = self
        parentsCoordinator?.viewController = viewController
        parentsCoordinator?.childCoordinators.append(self)
        self.navigationController.pushViewController(viewController, animated: false)
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
    
    func showMemoListViewController() {
        guard let viewController = self.viewController else { return }
        let memoListCoordinator = MemoListCoordinator(presentingViewController: viewController)
        memoListCoordinator.parentsCoordinator = self
        self.childCoordinators.append(memoListCoordinator)
        memoListCoordinator.start()
    }
}
