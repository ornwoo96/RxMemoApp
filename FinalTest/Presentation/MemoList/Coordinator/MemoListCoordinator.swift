//
//  MemoListCoordinator.swift
//  FinalTest
//
//  Created by 김동우 on 2021/12/29.
//

import UIKit

class MemoListCoordinator: Coordinator {
    weak var parentsCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController = UINavigationController()
    var viewController: ViewControllerProtocol?
    var presentingViewController: ViewControllerProtocol?
    
    init(navigationViewController: UINavigationController,
         viewController: ViewControllerProtocol) {
        self.navigationController = navigationViewController
        self.viewController = viewController
    }
    
    // MARK: 똑같이 반복되는 코드들 함수로 빼고 싶다~
    func setUpDIContainer(completion: ((UIViewController) -> Void)) {
        let memoListDIContainer = MemoListDIContainer()
        let viewController = memoListDIContainer.makeMemoListViewController()
        viewController.coordinator = self
        
        return completion(viewController)
    }
    
    func start() {
        setUpDIContainer { viewController in
            guard let viewController = viewController as? ViewControllerProtocol else { return }
            self.parentsCoordinator?.viewController = viewController
            self.parentsCoordinator?.childCoordinators.append(self)
            self.navigationController.pushViewController(viewController as! UIViewController, animated: false)
            self.viewController = viewController
        }
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func presentMemoListViewController() -> UINavigationController {
        let diContainer = MemoListDIContainer()
        let viewController = diContainer.makeMemoListViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        return navigationController
    }
    
    func showMemoDetailView(resultData: Result) {
        guard let viewController = self.viewController else { return }
        let memoDetailCoordinator = MemoDetailCoordinator(result: resultData,
                                                          navigationController: self.navigationController,
                                                          viewController: viewController)
        memoDetailCoordinator.parentsCoordinator = self
        self.childCoordinators.append(memoDetailCoordinator)
        memoDetailCoordinator.start()
    }
}
