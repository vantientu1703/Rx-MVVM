//
//  BaseViewModel.swift
//  RevivalPatient
//
//  Created by phuong.doan on 6/7/21.
//

import Foundation
import RxSwift

class BaseViewModel: NSObject {
    
    let disposeBag = DisposeBag()
    
    override init() {
        super.init()
        configRx()
    }
    
    let loading = ActivityIndicator()
    let headerLoading = ActivityIndicator()
    let footerLoading = ActivityIndicator()
    let limitRequest = ActivityIndicator()
    
    var showLoading: Observable<Bool> {
        return self.loading.asObservable()
    }
    
    var showHeaderLoading: Observable<Bool> {
        return self.headerLoading.asObservable()
    }
    
    var showFooterLoading: Observable<Bool> {
        return self.headerLoading.asObservable()
    }
    func configRx(){
        
    }
}
