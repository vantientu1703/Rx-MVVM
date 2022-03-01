//
//  UIButton.swift
//  RevivalPatient
//
//  Created by Vang Doan on 07/07/2021.
//

import Foundation
import UIKit

class HighlightableButton : UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.addTarget(self, action: #selector(didTouchUp), for: UIControl.Event.touchUpInside)
        self.addTarget(self, action: #selector(didTouchUp), for: UIControl.Event.touchCancel)
        self.addTarget(self, action: #selector(didTouchUp), for: UIControl.Event.touchDragExit)
        self.addTarget(self, action: #selector(didTouchDown), for: UIControl.Event.touchDown)
        
    }
    
    deinit {
        
        self.removeTarget(self, action: #selector(didTouchUp), for: UIControl.Event.touchUpInside)
        self.removeTarget(self, action: #selector(didTouchUp), for: UIControl.Event.touchCancel)
        self.removeTarget(self, action: #selector(didTouchUp), for: UIControl.Event.touchDragExit)
        self.removeTarget(self, action: #selector(didTouchDown), for: UIControl.Event.touchDown)
        
    }
    
    @objc func didTouchUp(){
        self.alpha = 1.0
    }
    
    @objc func didTouchDown(){
        self.alpha = 0.7
    }
    
}
extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true  // add this to maintain corner radius
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}
