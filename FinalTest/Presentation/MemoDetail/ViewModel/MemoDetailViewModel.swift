//
//  MemoDetailViewModel.swift
//  FinalTest
//
//  Created by 김동우 on 2022/01/01.
//

import Foundation

protocol MemoDetailViewModelInput {
    
}

protocol MemoDetailViewModelOuput {
    var result: Result { get }
}

protocol MemoDetailViewModelProtocol: MemoDetailViewModelInput, MemoDetailViewModelOuput {}

class MemoDetailViewModel: MemoDetailViewModelProtocol {
    private let memoUseCase: MemoUseCaseProtocol
    
    // MARK: Output
    var result = Result()
    
    init(result: Result, memoUseCase: MemoUseCaseProtocol) {
        self.memoUseCase = memoUseCase
        self.result = result
    }
    
}

// MARK: Input - View Methods
extension MemoDetailViewModel {
    
}
