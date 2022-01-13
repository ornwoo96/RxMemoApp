//
//  RepositoryProtocol.swift
//  FinalTest
//
//  Created by 김동우 on 2022/01/12.
//

import Foundation

protocol FetchResearchRepositoryProtocol {
    var resultData: [Result] { get set }
    
    func fetchResultData(query: String, completion: @escaping ((Error?, [Result]?) -> Void))
}


