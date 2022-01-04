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
        return result.descKor
    }
    
    var sugar: String? {
        return result.nutrCont5
    }
    
    init(result: Result) {
        self.result = result
    }
}
