//
//  MemoDetailDIContainer.swift
//  FinalTest
//
//  Created by 김동우 on 2022/01/01.
//

import Foundation

class MemoDetailDIContainer {
    
    func makeMemoDetailViewController(coordinator: MemoDetailCoordinatorProtocol,
                                      result: Result) -> MemoDetailViewController {
        return MemoDetailViewController.create(with: makeMemoDetailViewModel(result: result),
                                               coordinator: coordinator)
    }
    
    func makeMemoDetailViewModel(result: Result) -> MemoDetailViewModel {
        return MemoDetailViewModel(result: result, memoUseCase: makeMemoUseCase())
    }
    
    func makeMemoUseCase() -> MemoUseCase {
        return MemoUseCase()
    }
}
