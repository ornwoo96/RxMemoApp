//
//  MemoDetailCoordinator.swift
//  FinalTest
//
//  Created by 김동우 on 2022/01/01.
//

import Foundation
import UIKit

class MemoDetailCoordinator: Coordinator {
    weak var parentsCoordinator: MainCoordinator?
    var childCoordinators: [Coordinator] = []
    var result: Result
    var navigationController: UINavigationController
    
    init(result: Result, navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.result = result
    }
    
    func start() {
        let memoDetailDIContainer = MemoDetailDIContainer()
        let viewController = memoDetailDIContainer.makeMemoDetailViewController(result: result)
        viewController.coordinator = self
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func childDidFinish() {
        parentsCoordinator?.childDidFinish(self)
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
