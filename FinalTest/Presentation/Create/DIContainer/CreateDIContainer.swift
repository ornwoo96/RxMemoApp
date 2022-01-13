//
//  CreateDIContainer.swift
//  FinalTest
//
//  Created by 김동우 on 2022/01/10.
//

import Foundation

class CreateDIContainer {
    
    func makeCreateViewController() -> CreateViewController {
        return CreateViewController.create(with: makeCreateViewModel() as! CreateViewModel)
    }
    
    func makeCreateViewModel() -> CreateViewModelProtocol {
        return CreateViewModel(useCase: makeCreateUseCase())
    }
    
    func makeCreateUseCase() -> CreateUseCase {
        return CreateUseCase(repository: makeEntityRepository())
    }
    
    func makeEntityRepository() -> EntityRepository {
        return EntityRepository()
    }
}
