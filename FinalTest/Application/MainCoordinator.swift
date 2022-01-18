//
//  MainCoordinator.swift
//  testApp
//
//  Created by 김동우 on 2021/12/29.
//

import UIKit

class MainCoordinator: Coordinator {
    weak var parentsCoordinator: Coordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let createCoordinator = CreateCoordinator(navigationController: navigationController)
        createCoordinator.parentsCoordinator = self
        self.childCoordinators.append(createCoordinator)
        createCoordinator.start()
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

