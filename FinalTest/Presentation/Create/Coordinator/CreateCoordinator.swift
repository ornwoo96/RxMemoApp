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
    var viewController: ViewControllerProtocol?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let diContainer = CreateDIContainer()
        let viewController = diContainer.makeCreateViewController()
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
    
    
    // MARK: 이번 주에 와냐한테 물어보기
    func showMemoListViewController() {
        guard let presentViewController = self.viewController as? UIViewController else { return }
        guard let viewController = self.viewController else { return }
        
        let MemoListViewController = MemoListDIContainer().makeMemoListViewController()
        
        let navigation = UINavigationController(rootViewController: MemoListViewController)
        
        let coordinator = MemoListCoordinator(navigationViewController: navigation,
                                              viewController: viewController)
        
        MemoListViewController.coordinator = coordinator
        
        presentViewController.present(navigation, animated: true)
    }
}
