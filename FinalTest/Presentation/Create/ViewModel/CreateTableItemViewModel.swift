//
//  CreateTableCellViewModel.swift
//  FinalTest
//
//  Created by 김동우 on 2022/01/12.
//

import Foundation

struct CreateTableItemViewModel {
    let foodName: String
    let dang: String
    
    init(result: Result) {
        self.foodName = result.descKor ?? ""
        self.dang = result.nutrCont5 ?? ""
    }
}
