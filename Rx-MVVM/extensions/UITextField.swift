//
//  UITextField.swift
//  RevivalPatient
//
//  Created by Vang Doan on 15/07/2021.
//

import Foundation
import UIKit

@IBDesignable
//extension UITextField {
//
//    @IBInspectable var paddingLeftCustom: CGFloat {
//        get {
//            return leftView!.frame.size.width
//        }
//        set {
//            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
//            leftView = paddingView
//            leftViewMode = .always
//        }
//    }
//
//    @IBInspectable var paddingRightCustom: CGFloat {
//        get {
//            return rightView!.frame.size.width
//        }
//        set {
//            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
//            rightView = paddingView
//            rightViewMode = .always
//        }
//    }
//}

class RPTextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

extension UITextField {
    func disableAutoFill() {
            if #available(iOS 12, *) {
                textContentType = .oneTimeCode
            } else {
                textContentType = .init(rawValue: "")
            }
        }
}
