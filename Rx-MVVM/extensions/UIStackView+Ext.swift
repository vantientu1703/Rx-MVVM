//
//  UIStackView+Ext.swift
//  RevivalPatient
//
//  Created by nguyen minh tuan on 09/12/2021.
//

import Foundation
import UIKit

extension UIStackView {
    func removeFully(view: UIView) {
        removeArrangedSubview(view)
        view.removeFromSuperview()
    }
    
    func removeFullyAllArrangedSubviews() {
        arrangedSubviews.forEach { (view) in
            removeFully(view: view)
        }
    }
}
