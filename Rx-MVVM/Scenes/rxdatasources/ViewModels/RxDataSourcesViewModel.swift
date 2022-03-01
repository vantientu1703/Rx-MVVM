//
//  RxDataSourcesViewModel.swift
//  Rx-MVVM
//
//  Created by Tu Van on 01/03/2022.
//

import RxSwift
import RxRelay
import RxCocoa

class RxDataSourcesViewModel: BaseViewModel, ViewModelType {
    struct Input {
        let refresh: Observable<Void>
        let loadmore: Observable<Void>
    }
    
    struct Output {
        let didGetContents: Driver<[ContentSection]>
    }
    
    private let service: RMServiceProtocol
    
    init(service: RMServiceProtocol = RMService()) {
        self.service = service
    }
    
    private let offset: Int = 20
    
    private let _sections = BehaviorRelay<[ContentSection]>(value: [])
    var sections: [ContentSection] {
        return self._sections.value
    }
    
    func transform(input: Input) -> Output {
        let sections = [ContentSection.section(title: "", items: [])]
        let initState = SectionedTableViewState<ContentSection>(sections: sections)
        let command = PublishSubject<TableViewEditingCommand<ContentItem>>()
        
        command
            .scan(initState) { (state, action) -> SectionedTableViewState<ContentSection> in
                return state.execute(command: action)
            }
            .startWith(initState)
            .map { $0.sections }
            .bind(to: self._sections) .disposed(by: self.disposeBag)
        // first load
        self.service.getContents()
        
        return Output(didGetContents: self._sections.asDriverOnErrorJustComplete())
    }
}
