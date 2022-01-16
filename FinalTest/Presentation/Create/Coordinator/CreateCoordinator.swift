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
    var viewController: MemoListParentable?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let diContainer = CreateDIContainer()
        let viewController = diContainer.makeCreateViewController(coordinator: self)
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
    
    func presentMemoListViewController() {
        guard let parentViewController = viewController as? UIViewController & MemoListParentable else { return }
        let coordinator = MemoListCoordinator(viewController: parentViewController)
        let presentView = coordinator.memoListDIContainer.presentMemoListViewController(coordinator: coordinator)
        parentViewController.present(presentView, animated: true)
    }
}
