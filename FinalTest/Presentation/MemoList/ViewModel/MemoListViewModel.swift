//
//  MemoListViewModel.swift
//  FinalTest
//
//  Created by 김동우 on 2021/12/29.
//

import Foundation
import RxSwift
import RxRelay

class MemoListViewModel {
    let resultUseCase: ResultUseCaseProtocol // 확장성을 고려하기위해
    // BehaviorRelay로 ResultViewModel을 생성해놓고
    var resultViewModel = BehaviorRelay<[ResultViewModel]>(value: [])
    
    // Observable로 위에 생성해놓은 BehaviorRelay<[ResultViewModel]> 타입의 배열에 데이터가 바뀔떄마다
    // 감시하다가 Subscriber에게 알려줌!
    var resultViewModelObserver: Observable<[ResultViewModel]> {
        return resultViewModel.asObservable()
    }
    
    var resultData = PublishSubject<[Result]>()
    
    init(resultUseCase: ResultUseCaseProtocol) {
        self.resultUseCase = resultUseCase
    }
    
    func fetchResult() -> Observable<[ResultViewModel]> {
        // 이해가 안됨 map안에 map?? 근데 들어간다고? // repository에 들어가야될 내용인건가?
        resultUseCase.fetchResult().map { $0.map { ResultViewModel(result: $0) } }
    }
    
    func fetchResultData() -> [Result] {
        return resultUseCase.resultData
    }
}
