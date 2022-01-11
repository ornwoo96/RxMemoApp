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
    var presentingViewController: viewControllerProtocol?
    
    init(navigationController: UINavigationController,
         presentingViewController: viewControllerProtocol) {
        self.navigationController = navigationController
        self.presentingViewController = presentingViewController
    }
    
    func start() {
        let diContainer = CreateDIContainer()
        let actions = CreateViewModelAction()
        let viewController = diContainer.makeCreateViewController(actions: actions)
        viewController.coordinator = self
        parentsCoordinator?.viewController = viewController
        parentsCoordinator?.childCoordinators.append(self)
        guard let presentingView = presentingViewController as? UIViewController else { return }
        presentingView.present(viewController, animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
