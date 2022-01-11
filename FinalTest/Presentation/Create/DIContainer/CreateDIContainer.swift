//
//  CreateDIContainer.swift
//  FinalTest
//
//  Created by 김동우 on 2022/01/10.
//

import Foundation

class CreateDIContainer {
    
    func makeCreateViewController(actions: CreateViewModelAction) -> CreateViewController {
        return CreateViewController.create(with: makeCreateViewModel(actions: actions) as! CreateViewModel)
    }
    
    func makeCreateViewModel(actions: CreateViewModelAction) -> CreateViewModelProtocol {
        return CreateViewModel(useCase: makeCreateUseCase(), actions: actions)
    }
    
    func makeCreateUseCase() -> CreateUseCaseProtocol {
        return CreateUseCase()
    }
}
