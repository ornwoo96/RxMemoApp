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
        // MARK: 여기서 맵 사용 viewModel 타입으로 데이터 핸들링 이렇게 하는게 맞나? 어쩃든 잘됨...;;;
            .subscribe(onNext: { [weak self] str in
                self?.entityCount = str.count
                self?.entity.accept(self?.convertEntityData(entity: str) ?? [])
            })
            .disposed(by: disposeBag)
    }
    
    func convertEntityData(entity: [Entity]) -> [CreateTableItemViewModel] {
        var entityArray: [CreateTableItemViewModel] = []
        
        for i in entity {
            let a = CreateTableItemViewModel(entity: i)
            entityArray.append(a)
        }
        
        return entityArray
    }
}
