//
//  MemoListDIContainer.swift
//  FinalTest
//
//  Created by 김동우 on 2021/12/29.
//

import Foundation

class MemoListDIContainer {
    
    func makeMemoListViewController() -> MemoListViewController {
        return MemoListViewController.create(with: makeMemoListViewModel())
    }
    
    func makeMemoListViewModel() -> MemoListViewModel {
        return MemoListViewModel(resultUseCase: makeResultUseCase())
    }
    
    func makeResultUseCase() -> ResultUseCaseProtocol {
        return ResultUseCase(repository: makeFetchResearchRepository())
    }
    
    func makeFetchResearchRepository() -> FetchResearchRepository {
        return FetchResearchRepository()
    }
}
