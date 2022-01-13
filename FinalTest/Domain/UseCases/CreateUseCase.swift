//
//  CreateUseCase.swift
//  FinalTest
//
//  Created by 김동우 on 2022/01/10.
//

import Foundation
import RxSwift

protocol CreateUseCaseProtocol {
    
}

class CreateUseCase: CreateUseCaseProtocol {
    private let repository: EntityRepository
    
    init(repository: EntityRepository) {
        self.repository = repository
    }
    
    func execute() -> Observable<[Entity]> {
        return Observable.create { (observer) -> Disposable in
            self.repository.loadEnetityData { (error, data) in
                if let data = data {
                    observer.onNext(data)
                }
                if let error = error {
                    observer.onError(error)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}
