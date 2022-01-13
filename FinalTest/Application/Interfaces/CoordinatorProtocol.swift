//
//  CoordinatorProtocol.swift
//  FinalTest
//
//  Created by 김동우 on 2022/01/12.
//

import Foundation

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var parentsCoordinator: Coordinator? { get set }
    var viewController: ViewControllerProtocol? { get set }
    
    func start()
    func childDidFinish(_ child: Coordinator?)
    // func presentStart()
    // func pushStart()
}
