//
//  MemoListViewModel.swift
//  FinalTest
//
//  Created by 김동우 on 2021/12/29.
//

import Foundation
import RxSwift
import RxRelay

protocol MemoListViewModelInput {
    func fetchResult(query: String)
}

protocol MemoListViewModelOuput {
    var resultViewModel: BehaviorRelay<[ResultViewModel]> { get }
    var result: [Result] { get }
}

protocol MemoListViewModelProtocol: MemoListViewModelInput, MemoListViewModelOuput {}

class MemoListViewModel: MemoListViewModelProtocol {
    private let resultUseCase: ResultUseCaseProtocol
    
    // MARK: Ouput
    var resultViewModel = BehaviorRelay<[ResultViewModel]>(value: [])
    
    var result: [Result] = []
    var disposeBag = DisposeBag()
    
    
    init(resultUseCase: ResultUseCaseProtocol) {
        self.resultUseCase = resultUseCase
    }
    
    func fetchResult(query: String) {
        resultUseCase.fetchResult(query: query) { [weak self] data in
            self?.result = data
        }
        .map { $0.map { ResultViewModel(result: $0) } }
        .subscribe(onNext: { [weak self] result in
            self?.resultViewModel.accept(result)
        })
        .disposed(by: disposeBag)
    }
}

    // MARK: Input - View Methods
extension MemoListViewModel {
    
    func viewDidLoad() {}
    
    
}
