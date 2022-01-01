//
//  ResultViewModel.swift
//  FinalTest
//
//  Created by 김동우 on 2021/12/30.
//

import Foundation

struct ResultViewModel {
    private let result: Result
    
    var foodName: String? {
        return result.foodName
    }
    
    var sugar: String? {
        return result.sugar
    }
    
    init(result: Result) {
        self.result = result
    }
}
