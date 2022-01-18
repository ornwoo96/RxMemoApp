//
//  CreateCoordinator.swift
//  FinalTest
//
//  Created by 김동우 on 2022/01/10.
//

import Foundation
import UIKit

protocol CreateCoordinatorProtocol: Coordinator {
    func presentMemoListViewController()
}

class CreateCoordinator: CreateCoordinatorProtocol {
    weak var parentsCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var createDIContainer = CreateDIContainer()
    var viewController: MemoListParentable?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = createDIContainer.makeCreateViewController(coordinator: self)
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
