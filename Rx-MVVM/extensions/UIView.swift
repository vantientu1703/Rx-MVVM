//
//  UIView.swift
//  Revival
//
//  Created by phuong.doan on 5/8/21.
//

import Foundation
import UIKit

protocol ResponseUIView {}

extension ResponseUIView where Self: UIView {
    
    private static func fromNib<T: UIView>(_ type: T.Type) -> T? {
        if let view = Bundle.main.loadNibNamed(type.identifierString, owner: nil, options: nil)?.first, let _view = view as? T {
            return _view
        } else {
            return nil
        }
    }
    
    static func fromNib() -> Self? {
        return fromNib(self)
    }
}
extension UIPageControl {

    func customPageControl(dotFillColor:UIColor, dotBorderColor:UIColor, dotBorderWidth:CGFloat) {
        for (pageIndex, dotView) in self.subviews.enumerated() {
            if self.currentPage == pageIndex {
                dotView.backgroundColor = dotFillColor
                dotView.layer.cornerRadius = dotView.frame.size.height / 2
            }else{
                dotView.backgroundColor = .clear
                dotView.layer.cornerRadius = dotView.frame.size.height / 2
                dotView.layer.borderColor = dotBorderColor.cgColor
                dotView.layer.borderWidth = dotBorderWidth
            }
        }
    }

}
extension UIView: ResponseUIView { }

extension UIView {
    var backwardSafeAreaInsets: UIEdgeInsets {
        if #available(iOS 11, *) {
            return safeAreaInsets
        }
        return .zero
    }
    
    func addShadow() {
        self.clipsToBounds = false
        layer.applySketchShadow(color: UIColor(0, 0, 0, 1.0), alpha: 0.16, x: 0, y: 3, blur: 6, spread: 0)
    }
    
    func cornerRadius(corners: UIRectCorner, cornerRadii: CGSize) {
        let maskPath = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: cornerRadii)

        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        self.layer.mask = shape
    }
}

extension UIView {
    public func removeAllConstraints() {
        var _superview = self.superview
        
        while let superview = _superview {
            for constraint in superview.constraints {
                
                if let first = constraint.firstItem as? UIView, first == self {
                    superview.removeConstraint(constraint)
                }
                
                if let second = constraint.secondItem as? UIView, second == self {
                    superview.removeConstraint(constraint)
                }
            }
            
            _superview = superview.superview
        }
        
        self.removeConstraints(self.constraints)
        self.translatesAutoresizingMaskIntoConstraints = true
    }
    func rotate(angle: CGFloat) {
        let radians = angle / 180.0 * CGFloat.pi
        let rotation = self.transform.rotated(by: radians);
        self.transform = rotation
    }
    func pinEdges(to other: UIView) {
        leadingAnchor.constraint(equalTo: other.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: other.trailingAnchor).isActive = true
        topAnchor.constraint(equalTo: other.topAnchor).isActive = true
        bottomAnchor.constraint(equalTo: other.bottomAnchor).isActive = true
    }
    
    func defaultCornerRadius() {
        layer.cornerRadius = 5
    }
    
    func defaulBorderColor() {
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
    }
    
    func isCircle() {
        layer.cornerRadius = frame.height / 2
    }
    
    func removeSubviews() {
        for subview in self.subviews {
            subview.removeSubviews()
            
            subview.removeFromSuperview()
        }
    }
    
    func takeScreenshot() -> UIImage {
        // Begin context
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        // Draw view in that context
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        // And finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if (image != nil) {
            return image!
        }
        return UIImage()
    }
}

extension UIResponder {
    public var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}


class HighlightableView : UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for v in subviews {
            if let btn = v as? UIButton {
                btn.addTarget(self, action: #selector(didTouchUp), for: UIControl.Event.touchUpInside)
                btn.addTarget(self, action: #selector(didTouchUp), for: UIControl.Event.touchCancel)
                btn.addTarget(self, action: #selector(didTouchUp), for: UIControl.Event.touchDragExit)
                btn.addTarget(self, action: #selector(didTouchDown), for: UIControl.Event.touchDown)
            }
        }
    }
    
    deinit {
        for v in subviews {
            if let btn = v as? UIButton {
                btn.removeTarget(self, action: #selector(didTouchUp), for: UIControl.Event.touchUpInside)
                btn.removeTarget(self, action: #selector(didTouchUp), for: UIControl.Event.touchCancel)
                btn.removeTarget(self, action: #selector(didTouchUp), for: UIControl.Event.touchDragExit)
                btn.removeTarget(self, action: #selector(didTouchDown), for: UIControl.Event.touchDown)
            }
        }
    }
    
    @objc func didTouchUp(){
        self.alpha = 1.0
    }
    
    @objc func didTouchDown(){
        self.alpha = 0.7
    }
    
}
extension NSLayoutConstraint {
    func constraintWithMultiplier(_ multiplier: CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: self.firstItem!, attribute: self.firstAttribute, relatedBy: self.relation, toItem: self.secondItem, attribute: self.secondAttribute, multiplier: multiplier, constant: self.constant)
    }
}
extension UITableView {
    func autoSizeHeader(){
        if let headerView = self.tableHeaderView {

            let height = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
            var headerFrame = headerView.frame

            //Comparison necessary to avoid infinite loop
            if height != headerFrame.size.height {
                headerFrame.size.height = height
                headerView.frame = headerFrame
                self.tableHeaderView = headerView
            }
        }
    }
}
