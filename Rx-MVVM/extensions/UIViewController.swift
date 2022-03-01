//
//  UIViewController.swift
//  RevivalPatient
//
//  Created by phuong.doan on 5/20/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    func presentFullScreen(_ controller: UIViewController, animated: Bool, completion: (() -> Void)?) {
        controller.modalPresentationStyle = .overFullScreen
        self.present(controller, animated: animated, completion: completion)
    }
    
    func presentOverContext(_ viewController: UIViewController,
                            animated: Bool,
                            completion: (()->())?) {
        viewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        if let tabBarController = tabBarController {
            tabBarController.present(viewController, animated: animated, completion: completion)
        } else if let navigationController = navigationController {
            navigationController.present(viewController, animated: animated, completion: completion)
        } else {
            present(viewController, animated: animated, completion: completion)
        }
    }
    
    func customPresent(_ viewControllerToPresent: UIViewController,
                       animated flag: Bool,
                       completion: (() -> Void)? = nil) {
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        present(viewControllerToPresent, animated: true, completion: nil)
    }
    
    func presentVC(_ controller: UIViewController, animated: Bool, completion: (() -> Void)?) {
        (self.tabBarController ?? self.navigationController ?? self).present(controller, animated: animated, completion: completion)
    }
}
