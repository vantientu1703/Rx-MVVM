//
//  UITabelView+Ext.swift
//  BaseProject
//
//  Created by Văn Tiến Tú on 11/7/18.
//  Copyright © 2018 Văn Tiến Tú. All rights reserved.
//

import UIKit

extension UITableView {
    
    func registerCellByNib<T: UITableViewCell>(_ type: T.Type) {
        register(type.nib, forCellReuseIdentifier: type.identifierString)
    }
    
    func registerCell<T: UITableViewCell>(_ type: T.Type) {
        register(type, forCellReuseIdentifier: type.identifierString)
    }
    
    func registerHeaderFooter<T: UITableViewHeaderFooterView>(_ type: T.Type) {
        register(type.nib, forHeaderFooterViewReuseIdentifier: type.identifierString)
    }
    
    func dequeueCell<T: UITableViewCell>(_ type: T.Type, forIndexPath indexPath: IndexPath) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifierString, for: indexPath) as? T
    }
    
    func dequeueCell<T: UITableViewCell>(_ type: T.Type) -> T? {
        return dequeueReusableCell(withIdentifier: type.identifierString) as? T
    }
    
    func dequeueHeaderFooter<T: UITableViewHeaderFooterView>(_ type: T.Type) -> T? {
        return dequeueReusableHeaderFooterView(withIdentifier: type.identifierString) as? T
    }
    
    func cellForRow<T: UITableViewCell>(_ type: T.Type, at indexPath: IndexPath) -> T? {
        return self.cellForRow(at: indexPath) as? T
    }
    
    func headerViewForSection<T: UITableViewHeaderFooterView>(_ type: T.Type, at section: Int) -> T? {
        return self.headerView(forSection: section) as? T
    }
    
    func footerViewForSection<T: UITableViewHeaderFooterView>(_ type: T.Type, at section: Int) -> T? {
        return self.footerView(forSection: section) as? T
    }
    
    func showLoadMore(_ completionHandler: @escaping () -> Void) {
        // create indicatorview
        let activityIndicatorView = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            activityIndicatorView.style = .medium
        } else {
            // Fallback on earlier versions
            activityIndicatorView.style = UIActivityIndicatorView.Style.gray
        }
        // footerView
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: 50))
        footerView.addSubview(activityIndicatorView)
        activityIndicatorView.center = footerView.center
        footerView.backgroundColor = UIColor.clear
        // set to footerView
        self.tableFooterView = footerView
        // animating
        activityIndicatorView.startAnimating()
        // call back
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            completionHandler()
        }
    }
    
    func hideLoadMore() {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.3) {
                self.tableFooterView = nil
            }
        }
    }
    func scrollToBottom(isAnimated:Bool = true){
        
        DispatchQueue.main.async {
            let row = self.numberOfRows(inSection:  self.numberOfSections-1) - 1
            let section = self.numberOfSections - 1
            if row >= 0, section >= 0 {
                let indexPath = IndexPath(
                    row: row,
                    section: section)
                if self.hasRowAtIndexPath(indexPath: indexPath) {
                    self.scrollToRow(at: indexPath, at: .bottom, animated: isAnimated)
                }
            }
            
        }
    }
    
    func scrollToTop(isAnimated:Bool = true) {
        
        DispatchQueue.main.async {
            self.setContentOffset(CGPoint(x: 0, y: 0), animated: isAnimated)
        }
    }
    
    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
}
