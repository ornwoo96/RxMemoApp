//
//  CreateViewModel.swift
//  FinalTest
//
//  Created by 김동우 on 2022/01/10.
//

import Foundation

struct CreateViewModelAction {
    let createButtonDidTap: () -> Void
}

protocol CreateViewModelInput {
    func viewDidLoad()
    func createButtonDidTap()
}

protocol CreateViewModelOuput {
    
}

protocol CreateViewModelProtocol: CreateViewModelInput, CreateViewModelOuput {}

class CreateViewModel: CreateViewModelProtocol {
    private let useCase: CreateUseCaseProtocol
    private let actions: CreateViewModelAction?
    
    init(useCase: CreateUseCaseProtocol,
         actions: CreateViewModelAction) {
        self.useCase = useCase
        self.actions = actions
    }
}


// MARK: Input - Methods
extension CreateViewModel {
    
    func createButtonDidTap() {
        actions?.createButtonDidTap()
    }
    
    func viewDidLoad() {
        <#code#>
    }
}
