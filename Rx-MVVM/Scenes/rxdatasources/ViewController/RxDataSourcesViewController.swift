//
//  RxDataSourcesViewController.swift
//  Rx-MVVM
//
//  Created by Tu Van on 01/03/2022.
//

import UIKit
import RxSwift
import RxDataSources

class RxDataSourcesViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.refreshControl = self.refreshControl
    }
}
