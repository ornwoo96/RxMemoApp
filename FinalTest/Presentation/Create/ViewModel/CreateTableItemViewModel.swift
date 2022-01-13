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
    
    init(entity: Entity) {
        self.foodName = entity.foodName ?? ""
        self.dang = entity.dang ?? ""
    }
}
