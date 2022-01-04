//
//  MainCoordinator.swift
//  testApp
//
//  Created by 김동우 on 2021/12/29.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
    
    func childDidFinish(_ child: Coordinator?)
}

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let memoListCoordinator = MemoListCoordinator(navigationController: navigationController)
        memoListCoordinator.start()
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
}
