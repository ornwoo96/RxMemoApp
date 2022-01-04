//
//  FetchResearchRepository.swift
//  FinalTest
//
//  Created by 김동우 on 2022/01/03.
//

import Foundation
import Alamofire

class FetchResearchRepository {
    var resultData: [Result] = []
    
    func fetchResultData(completion: @escaping ((Error?, [Result]?) -> Void)) {
        let urlString = "https://openapi.foodsafetykorea.go.kr/api/786707ec222c40daa0a7/I2790/json"
        
        guard var url = URL(string: urlString) else { return completion(NSError(domain: "dongou705",
                                                                                code: 404,
                                                                                userInfo: nil), nil)}
        url.appendPathComponent("/1/5/DESC_KOR=김치")
        
        AF.request(url,
                   method: HTTPMethod.get,
                   headers: nil,
                   interceptor: nil,
                   requestModifier: nil)
            .responseJSON{ response in
                switch response.result {
                case .success(let json):
                    print(json)
                    do {
                        let dataJson = try JSONSerialization.data(withJSONObject: json,
                                                                  options: .prettyPrinted)
                        let jsonInstanceData = try JSONDecoder().decode(ResultName.self, from: dataJson)
                        
                        self.resultData = jsonInstanceData.apiNum.row
                        
                        return completion(nil, jsonInstanceData.apiNum.row)
                    } catch {
                        print(error)
                    }
                case .failure(let error):
                    return completion(error, nil)
                }
            }
    }
    
    func embeddedResultData(completion: @escaping (([Result]?) -> Void)) {
        return completion(resultData)
    }
}