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
    
    func start() // MARK: 무조건 PushView할때만
    func childDidFinish(_ child: Coordinator?)
}
