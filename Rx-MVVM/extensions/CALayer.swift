//
//  CALayer.swift
//  RevivalPatient
//
//  Created by Vang Doan on 21/07/2021.
//

import Foundation
import UIKit

extension CALayer {
    func applySketchShadow(color: UIColor = UIColor(203, 203, 203, 1), alpha: Float = 1, x: CGFloat = 0, y: CGFloat = 8, blur: CGFloat = 15, spread: CGFloat = 0) {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
    
    func removeSketchShadow() {
        shadowOpacity = 0.0
    }
}
