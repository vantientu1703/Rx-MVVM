//
//  ViewController.swift
//  Rx-MVVM
//
//  Created by Tu Van on 01/03/2022.
//

import UIKit
import RxSwift

class ViewController: BaseViewController {

    @IBOutlet weak var rxDataSourcesButton: UIButton!
    @IBOutlet weak var simulatorCallAPIButton: UIButton!
    
    var viewModel: MainViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Rx-MVVM"
        self.buildViewModel()
    }
    
    private func buildViewModel() {
        self.viewModel = MainViewModel()
        let input = MainViewModel.Input(simulatorButtonTriigered: self.simulatorCallAPIButton.rx.tap.asObservable().mapToVoid())
        let output = self.viewModel.transform(input: input)
        output
            .didCallAPiSuccess
            .drive(onNext: { [weak self] _ in
                
            })
            .disposed(by: self.disposeBag)
        
        self.showLoading(from: self.viewModel)
    }
}
