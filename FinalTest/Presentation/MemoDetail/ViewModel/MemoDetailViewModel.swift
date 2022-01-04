//
//  MemoDetailViewModel.swift
//  FinalTest
//
//  Created by 김동우 on 2022/01/01.
//

import Foundation

class MemoDetailViewModel {
    
    private let memoUseCase: MemoUseCaseProtocol
    var result = Result()
    
    init(result: Result, memoUseCase: MemoUseCaseProtocol) {
        self.memoUseCase = memoUseCase
        self.result = result
    }
    
}
