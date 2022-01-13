//
//  CreateViewModel.swift
//  FinalTest
//
//  Created by 김동우 on 2022/01/10.
//

import Foundation

protocol CreateViewModelInput {
    func viewDidLoad()
}

protocol CreateViewModelOuput {
    
}

protocol CreateViewModelProtocol: CreateViewModelInput, CreateViewModelOuput {}

class CreateViewModel: CreateViewModelProtocol {
    private let useCase: CreateUseCaseProtocol
    
    
    init(useCase: CreateUseCaseProtocol) {
        self.useCase = useCase
    }
}


// MARK: Input - Methods
extension CreateViewModel {
    
    func viewDidLoad() { }
}
