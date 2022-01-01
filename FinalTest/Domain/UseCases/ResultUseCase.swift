//
//  ResultRepositories.swift
//  FinalTest
//
//  Created by 김동우 on 2021/12/30.
//

import Foundation
import Alamofire
import RxSwift

protocol ResultUseCaseProtocol {
    func fetchResult() -> Observable<[Result]>
}

class ResultUseCase: ResultUseCaseProtocol {
    
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
        let urlString = "https://openapi.foodsafetykorea.go.kr/api/786707ec222c40daa0a7/I2790/json"
//        let urlString = "https://openapi.foodsafetykorea.go.kr/api/786707ec222c40daa0a7/I2790/json/1/5/DESC_KOR=김치"
        let parameters: Parameters = [
            "startIdx" : 1,
            "endIdx" : 5,
            "DESC_KOR" : "김치"
        ]
//    https://openapi.foodsafetykorea.go.kr/api/786707ec222c40daa0a7/I2790/json/1/5/DESC_KOR=김치
        guard var url = URL(string: urlString) else { return completion(NSError(domain: "dongou705",
                                                                                code: 404,
                                                                                userInfo: nil), nil)}
        url.appendPathComponent("/1/5/DESC_KOR=김치")
//        AF.request(url,
//                   method: HTTPMethod.get,
//                   parameters: parameters,
//                   encoding: JSONEncoding.default,
//                   headers: nil,
//                   interceptor: nil,
//                   requestModifier: nil)
//            .responseDecodable(of: ResultName.self) { response in
//                switch response.result {
//                case.success(let data):
//                    return completion(nil, data.apiNum.row)
//
//                case.failure(let error):
//                    return completion(error, nil) // 왜 에러뜨징?
//                }
//            }
//
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
                        return completion(nil, jsonInstanceData.apiNum.row)
                    } catch {
                        print(error)
                    }
//                    return completion(nil, json)
                case .failure(let error):
                    return completion(error, nil)
                }
            }
    }
}
