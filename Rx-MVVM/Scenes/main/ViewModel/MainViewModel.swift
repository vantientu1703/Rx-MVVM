//
//  MainViewModel.swift
//  Rx-MVVM
//
//  Created by Tu Van on 01/03/2022.
//

import RxSwift
import RxCocoa

class MainViewModel: BaseViewModel, ViewModelType {
    struct Input {
        let simulatorButtonTriigered: Observable<Void>
    }
    
    struct Output {
        let didCallAPiSuccess: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        
        let callApi = input.simulatorButtonTriigered
            .flatMapLatest { [weak self] _ -> Observable<Void> in
                guard let self = self else { return .empty() }
                return self.makeApi()
                    .trackActivity(self.loading)
            }
        
        return Output(didCallAPiSuccess: callApi.asDriverOnErrorJustComplete())
    }
    
    // giả lập call api
    private func makeApi() -> Observable<Void> {
        return Observable.create { observer in
            sleep(5)
            observer.onNext(())
            observer.onCompleted()
            return Disposables.create()
        }
        .subscribe(on: ConcurrentDispatchQueueScheduler.init(qos: .background))
    }
}
