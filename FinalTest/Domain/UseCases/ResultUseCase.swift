//
//  ResultRepositories.swift
//  FinalTest
//
//  Created by 김동우 on 2021/12/30.
//

import Foundation
import Alamofire
import RxSwift

class ResultUseCase {
    
    func fetchResult() -> Observable<[Result]> {
        return Observable.create { (observer) -> Disposable in
            
            self.fetchResultData { (error, row) in
                if let error = error {
                    observer.onError(error)
                }
                
                if let row = row {
                    observer.onNext(row)
                }
                
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
    }
    
    private func fetchResultData(completion: @escaping ((Error?, [Result]?) -> Void)) {
        let urlString = "http://openapi.foodsafetykorea.go.kr/api/786707ec222c40daa0a7/I2790/json/1/5/DESC_KOR=김치"
        
        guard let url = URL(string: urlString) else { return completion(NSError(), [])}
        
        AF.request(url,
                   method: HTTPMethod.get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: nil,
                   interceptor: nil,
                   requestModifier: nil)
            .responseDecodable(of: ResultResponse.self) { response in
                if let error = response.error {
                    return completion(error, nil)
                }
                
                if let results = response.value?.row {
                    return completion(nil, results)
                }
            }
    }
}
