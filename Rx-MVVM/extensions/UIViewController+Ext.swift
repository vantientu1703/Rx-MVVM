//
//  UIViewController+Ext.swift
//  BaseProject
//
//  Created by Văn Tiến Tú on 11/7/18.
//  Copyright © 2018 Văn Tiến Tú. All rights reserved.
//

import UIKit

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    func transform(input: Input) -> Output
}

public protocol BindableType: AnyObject {
    associatedtype ViewModelType
    var viewModel: ViewModelType! { get set }
    func bindViewModel()
}

public extension BindableType where Self: UIViewController {
    func bind(to model: Self.ViewModelType) {
        viewModel = model
        loadViewIfNeeded()
        bindViewModel()
    }
}

protocol ResponseUIViewController {}

extension ResponseUIViewController where Self: UIViewController {
    static func fromNib() -> Self {
        return self.init(nibName: String(describing: self), bundle: nil)
    }
    
    static func fromStoryboard(_ storyboardName: UIStoryboard.StoryboardName, withIdentifier: String = Self.identifierString) -> Self? {
        return Self.fromStoryboard(self, storyboardName: storyboardName, withIdentifier: withIdentifier)
    }
    
    private static func fromStoryboard<T: UIViewController>(_ type: T.Type, storyboardName: UIStoryboard.StoryboardName, withIdentifier: String?) -> T? {
        let storyboard = UIStoryboard(storyboard: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(type)
    }
}

extension UIViewController: ResponseUIViewController {
    
    enum ViewControllerName {
        case login
        case signUp
        case forgotPassword
        case resetPassword
        
        var identifier: String {
            switch self {
            case .login:
                return "Login"
            case .signUp:
                return "Sign up"
            case .forgotPassword:
                return "Forgot Password"
            case .resetPassword:
                return "Reset Password"
            }
        }
    }
}

extension UIViewController {
    
    func present(to controller: UIViewController, transaction: CATransitionType = .fade, duration: CFTimeInterval = 0.33, transitionSubType: CATransitionSubtype, completion: (() -> Void)?) {
        let trans = CATransition()
        trans.duration = duration
        trans.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        trans.type = transaction
        trans.subtype = transitionSubType
        self.view.window?.layer.add(trans, forKey: kCATransactionAnimationTimingFunction)
        self.present(controller, animated: false, completion: completion)
    }
    
    func dismiss(transaction: CATransitionType = .fade, duration: CFTimeInterval = 0.33, transitionSubType: CATransitionSubtype, completion: (() -> Void)?) {
        let trans = CATransition()
        trans.duration = duration
        trans.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        trans.type = transaction
        trans.subtype = transitionSubType
        self.view.window?.layer.add(trans, forKey: kCATransactionAnimationTimingFunction)
        self.dismiss(animated: false, completion: completion)
    }
    
    func push(to controller: UIViewController, transaction: CATransitionType = .fade, duration: CFTimeInterval = 0.33, transitionSubType: CATransitionSubtype, completion: (() -> Void)?) {
        let trans = CATransition()
        trans.duration = duration
        trans.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        trans.type = transaction
        trans.subtype = transitionSubType
        self.view.window?.layer.add(trans, forKey: kCATransactionAnimationTimingFunction)
        self.navigationController?.pushViewController(controller, animated: false)
        completion?()
    }
    
    @discardableResult
    func pop(transaction: CATransitionType = .fade, duration: CFTimeInterval = 0.33, transitionSubType: CATransitionSubtype) -> UIViewController? {
        let trans = CATransition()
        trans.duration = duration
        trans.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        trans.type = transaction
        trans.subtype = transitionSubType
        self.view.window?.layer.add(trans, forKey: kCATransactionAnimationTimingFunction)
        return self.navigationController?.popViewController(animated: false)
    }
    func resizeHeader(tableView:UITableView){
        guard let headerView = tableView.tableHeaderView else {
          return
        }
        let width = tableView.bounds.size.width
        let size = headerView.systemLayoutSizeFitting(CGSize(width: width, height: UIView.layoutFittingCompressedSize.height))
        if headerView.frame.size.height != size.height {
            headerView.frame.size.height = size.height
          tableView.tableHeaderView = headerView
        }
    }
    func resizeFooter(tableView:UITableView){
        guard let footerView = tableView.tableFooterView else {
          return
        }
        let width = tableView.bounds.size.width
        let size = footerView.systemLayoutSizeFitting(CGSize(width: width, height: UIView.layoutFittingCompressedSize.height))
        if footerView.frame.size.height != size.height {
            footerView.frame.size.height = size.height
          tableView.tableFooterView = footerView
        }
    }
}
