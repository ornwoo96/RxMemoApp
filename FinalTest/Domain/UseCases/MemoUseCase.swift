//
//  MemoUseCase.swift
//  testApp
//
//  Created by 김동우 on 2021/12/29.
//

import Foundation

protocol MemoUseCaseProtocol: AnyObject {
    func createEntity(result: Result)
    func loadEnetityData()
}

class MemoUseCase: MemoUseCaseProtocol {
    func createEntity(result: Result) {
        CoreDataHelper.instance.createEntity(foodName: result.descKor ?? "", dang: result.nutrCont5 ?? "")
    }
    
    func loadEnetityData() {
        
    }
}
