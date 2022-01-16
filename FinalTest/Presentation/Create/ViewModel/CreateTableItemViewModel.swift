//
//  CreateTableCellViewModel.swift
//  FinalTest
//
//  Created by 김동우 on 2022/01/12.
//

import Foundation
import RxSwift
import RxRelay

class CreateTableItemViewModel {
    var entityItem = BehaviorRelay<Entity>(value: .init())
    
    init(entity: Entity) {
        self.entityItem.accept(entity)
    }
}
