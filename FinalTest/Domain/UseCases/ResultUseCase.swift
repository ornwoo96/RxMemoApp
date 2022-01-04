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
    var resultData: [Result] { get }
    
    var repository: FetchResearchRepository? { get set }
}

class ResultUseCase: ResultUseCaseProtocol {
    
    var repository: FetchResearchRepository?
    var resultData: [Result] = []
    
    init(repository: FetchResearchRepository) {
        self.repository = repository
    }
    
    func fetchResult() -> Observable<[Result]> {
        return Observable.create { (observer) -> Disposable in
            self.repository?.fetchResultData { (error, row) in
                if let error = error {
                    observer.onError(error)
                }
                if let row = row {
                    observer.onNext(row)
                    self.resultData = row
                }
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
//    func resultData(completion: @escaping (([Result]?) -> Void))  {
//        repository?.embeddedResultData { result in
//
//        }
//    }
    
}
