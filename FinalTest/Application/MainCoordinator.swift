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
    var viewController: ViewControllerProtocol?
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let createCoordinator = CreateCoordinator(navigationController: navigationController)
        createCoordinator.parentsCoordinator = self
        self.childCoordinators.append(createCoordinator)
        createCoordinator.start()
    }
    
    // MARK: 이건 삭제~
    func childDidFinish(_ child: Coordinator?){
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    // MARK: 코디네이터 패턴 - 
}
