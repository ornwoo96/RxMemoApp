//
//  MemoDetailCoordinator.swift
//  FinalTest
//
//  Created by 김동우 on 2022/01/01.
//

import Foundation
import UIKit

protocol MemoDetailCoordinatorProtocol: Coordinator {
    func dismiss()
}

class MemoDetailCoordinator: MemoDetailCoordinatorProtocol {
    weak var parentsCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var memoDetailDIContainer = MemoDetailDIContainer()
    var viewController: MemoListParentable?
    var result: Result
    var navigationController: UINavigationController
    
    init(result: Result,
         navigationController: UINavigationController,
         viewController: MemoListParentable) {
        self.navigationController = navigationController
        self.result = result
        self.viewController = viewController
    }
    
    func start() {
        let viewController = memoDetailDIContainer.makeMemoDetailViewController(coordinator: self,
                                                                                result: result)
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
    
    func dismiss() {
        if let viewController = self.viewController as? UIViewController {
            self.viewController?.parentActing()
            // MARK: 여기서 뷰컨은 createViewController인데 dismiss가 되넹?
            viewController.dismiss(animated: true, completion: nil)
        }
    }
}
