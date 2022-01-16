//
//  ResultViewModel.swift
//  FinalTest
//
//  Created by 김동우 on 2021/12/30.
//

import Foundation
import RxRelay

struct ResultViewModel {
    static let empty: Self = .init(result: .empty)
    
    var foodName: String = ""
    var sugar: String = ""
    
    init(result: Result) {
        guard let foodName = result.descKor,
              let sugar = result.nutrCont5 else {
                  return
              }
        
        self.foodName = foodName
        self.sugar = sugar
    }
}

class MemoListItemViewModel {
    var items = BehaviorRelay<ResultViewModel>(value: .empty)
    
    init(items: ResultViewModel) {
        self.items.accept(items)
    }
}
