//
//  coreDataHelper.swift
//  FinalTest
//
//  Created by 김동우 on 2022/01/11.
//

import Foundation
import CoreData
import UIKit

class CoreDataHelper {
    static let instance = CoreDataHelper()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func createEntity(foodName: String,
                      dang: String) {
        let newEntity = Entity(context: context)
        newEntity.do {
            $0.foodName = foodName
            $0.dang = dang
        }
        do {
            try context.save()
            print("세이브 성공!")
        } catch {
            print(error)
        }
    }
    
    func getEntity(completion: @escaping ((Error?, [Entity]?) -> Void)) {
        var entity = [Entity]()
        do {
            entity = try context.fetch(Entity.fetchRequest())
            return completion(nil, entity)
            print("entity 가져오기 성공!")
        } catch {
            print(error)
        }
    }
}
