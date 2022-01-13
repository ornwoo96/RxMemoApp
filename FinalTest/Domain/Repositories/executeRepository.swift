//
//  EntityRepository.swift
//  FinalTest
//
//  Created by 김동우 on 2022/01/12.
//

import Foundation

class EntityRepository {
    func createEntity(result: Result) {
        CoreDataHelper.instance.createEntity(foodName: result.descKor ?? "", dang: result.nutrCont5 ?? "")
    }
    
    func loadEnetityData(completion: @escaping ((Error?, [Entity]?) -> Void)) {
        CoreDataHelper.instance.getEntity { error, data in
            if let data = data {
                return completion(nil, data)
            }
            if let error = error {
                return completion(error, nil)
            }
        }
    }
}
