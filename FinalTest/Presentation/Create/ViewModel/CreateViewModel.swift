//
//  CreateViewModel.swift
//  FinalTest
//
//  Created by 김동우 on 2022/01/10.
//

import Foundation
import RxRelay
import RxSwift

protocol CreateViewModelInput {
    func viewDidLoad()
}

protocol CreateViewModelOuput {
    var entity: BehaviorRelay<[CreateTableItemViewModel]> { get }
    var entityCount: Int { get }
}

protocol CreateViewModelProtocol: CreateViewModelInput, CreateViewModelOuput {}

class CreateViewModel: CreateViewModelProtocol {
    private let useCase: CreateUseCase
    var entity = BehaviorRelay<[CreateTableItemViewModel]>(value: [])
    var entityCount = 0
    
    var disposeBag = DisposeBag()
    
    init(useCase: CreateUseCase) {
        self.useCase = useCase
    }
}


// MARK: Input - Methods
extension CreateViewModel {
    
    func viewDidLoad() {
        useCase.execute()
            .map { $0.map { CreateTableItemViewModel(entity: $0) } }
            .subscribe(onNext: { [weak self] entityData in
                self?.entityCount = entityData.count
                self?.entity.accept(entityData)
            }).disposed(by: disposeBag)
    }
}
