//
//  MemoListDIContainer.swift
//  FinalTest
//
//  Created by 김동우 on 2021/12/29.
//

import Foundation
import UIKit

class MemoListDIContainer {
    func presentMemoListViewController(coordinator: MemoListCoordinatorProtocol) -> UINavigationController {
        let navigationView = UINavigationController(rootViewController: makeMemoListViewController(coordinator: coordinator))
        return navigationView
    }
    
    func makeMemoListViewController(coordinator: MemoListCoordinatorProtocol) -> MemoListViewController {
        return MemoListViewController.create(with: makeMemoListViewModel() as! MemoListViewModel,
                                             coordinator: coordinator)
    }
    
    func makeMemoListViewModel() -> MemoListViewModelProtocol {
        return MemoListViewModel(resultUseCase: makeResultUseCase())
    }
    
    func makeResultUseCase() -> ResultUseCaseProtocol {
        return ResultUseCase(repository: makeFetchResearchRepository())
    }
    
    func makeFetchResearchRepository() -> FetchResearchRepository {
        return FetchResearchRepository()
    }
}
