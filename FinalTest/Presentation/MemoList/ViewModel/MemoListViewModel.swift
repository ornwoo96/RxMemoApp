//
//  MemoListViewModel.swift
//  FinalTest
//
//  Created by 김동우 on 2021/12/29.
//

import Foundation
import RxSwift

class MemoListViewModel {
    
    private let resultUseCase: ResultUseCaseProtocol // 확장성을 고려하기위해
    
    init(resultUseCase: ResultUseCaseProtocol) {
        self.resultUseCase = resultUseCase
    }
    
    func fetchResult() -> Observable<[ResultViewModel]> {
        // 이해가 안됨 map안에 map?? 근데 들어간다고? // repository에 들어가야될 내용인건가?
        resultUseCase.fetchResult().map { $0.map { ResultViewModel(result: $0) } }
    }
    
}
