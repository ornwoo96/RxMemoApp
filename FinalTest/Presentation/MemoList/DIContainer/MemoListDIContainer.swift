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
        return MemoListViewModel(memoUseCase: makeMemoUseCase())
    }
    
    func makeMemoUseCase() -> MemoUseCase {
        return MemoUseCase()
    }
}
