//
//  MemoListDIContainer.swift
//  FinalTest
//
//  Created by 김동우 on 2021/12/29.
//

import Foundation

class MemoListDIContainer {
    
    func makeMemoListViewController(actions: MemoListViewModelActions) -> MemoListViewController {
        return MemoListViewController.create(with: makeMemoListViewModel(actions: actions) as! MemoListViewModel)
    }
    
    func makeMemoListViewModel(actions: MemoListViewModelActions) -> MemoListViewModelProtocol {
        return MemoListViewModel(resultUseCase: makeResultUseCase(), actions: actions)
    }
    
    func makeResultUseCase() -> ResultUseCaseProtocol {
        return ResultUseCase(repository: makeFetchResearchRepository())
    }
    
    func makeFetchResearchRepository() -> FetchResearchRepository {
        return FetchResearchRepository()
    }
}
