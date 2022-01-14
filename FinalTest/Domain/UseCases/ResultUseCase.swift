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
    var resultData: [Result] { get }
    var repository: FetchResearchRepository? { get set }
    
    func fetchResult(query: String, completion: @escaping (([Result]) -> Void)) -> Observable<[Result]>
}

class ResultUseCase: ResultUseCaseProtocol {
    // MARK: 엥? internal???
    internal var repository: FetchResearchRepository?
    var resultData: [Result] = []
    
    init(repository: FetchResearchRepository) {
        self.repository = repository
    }
    
    func fetchResult(query: String, completion: @escaping (([Result]) -> Void)) -> Observable<[Result]> {
        return Observable.create { (observer) -> Disposable in
            self.repository?.fetchResultData(query: query) { (error, row) in
                if let error = error {
                    observer.onError(error)
                }
                if let row = row {
                    self.resultData = row
                    observer.onNext(row)
                    
                    return completion(self.resultData)
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}
