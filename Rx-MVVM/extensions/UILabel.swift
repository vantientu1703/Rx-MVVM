//
//  UILabel.swift
//  Revival
//
//  Created by phuong.doan on 5/9/21.
//

import Foundation
import UIKit

class BaseLabel: UILabel {
    @IBInspectable var isUnderLine:    Bool =  false { didSet { showUnderLine() }}
    func showUnderLine(){
        guard let text = text else { return }
        let textRange = NSRange(location: 0, length: text.count)
        let attributedText = NSMutableAttributedString(string: text)
        attributedText.addAttribute(.underlineStyle,
                                    value: NSUnderlineStyle.single.rawValue,
                                    range: textRange)
        // Add other attributes if needed
        self.attributedText = attributedText
    }
}
extension UITextView {
    func setTextWithHighlight(_ pText: String = "", _ pColor: UIColor = .black, _ pFont: UIFont?, highlightText: [String], highlightColor: [UIColor], highlightFont: [UIFont?], spacing: CGFloat = 2.5, alignment: NSTextAlignment? = nil) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        paragraphStyle.lineBreakMode = .byTruncatingTail
        if let alignment = alignment {
            paragraphStyle.alignment = alignment
        }
        
        let attributeString = NSMutableAttributedString(string: pText)
        
        attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSAttributedString.Key.font, value: pFont ?? UIFont.systemFont(ofSize: 13), range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: pColor, range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributeString.length))
        
        
        if highlightText.count == highlightColor.count && highlightColor.count == highlightFont.count {
            for index in 0..<highlightText.count {
                let tText = highlightText[index]
                let tColor = highlightColor[index]
                let tFont = highlightFont[index]
                
                if let tRange = pText.range(of: tText) {
                    let nsRange = pText.nsRange(from: tRange)
                    
                    attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: tColor, range:nsRange)
                    attributeString.addAttribute(NSAttributedString.Key.font, value: tFont ?? UIFont.systemFont(ofSize: 13), range:nsRange)
                }
            }
        }
        
        self.attributedText = attributeString
    }
}
extension UILabel {
    func getHeight() -> CGFloat {
        let textSize = CGSize.init(width: frame.size.width,
                                   height: CGFloat(MAXFLOAT))
        return sizeThatFits(textSize).height
    }
    
    func getWidth() -> CGFloat {
        let textSize = CGSize.init(width: CGFloat(MAXFLOAT),
                                   height: frame.size.width)
        return sizeThatFits(textSize).width
    }
    
    func setMiddleLine(_ title: String? = "", color: UIColor = .black, font: UIFont = .systemFont(ofSize: 13) ?? UIFont.systemFont(ofSize: 13), spacing: CGFloat = 0) {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        paragraphStyle.lineBreakMode = .byTruncatingTail
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: title ?? "")
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSAttributedString.Key.font, value: font, range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributeString.length))
        
        self.attributedText = attributeString
    }
    
    func setAttribute(_ text: String? = "", color: UIColor = .black, font: UIFont? = .systemFont(ofSize: 13), spacing: CGFloat = 2.5) {
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        paragraphStyle.lineBreakMode = .byTruncatingTail
        
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: text ?? "")
        attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSAttributedString.Key.font, value: font ?? UIFont.systemFont(ofSize: 13), range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: NSMakeRange(0, attributeString.length))
        
        self.attributedText = attributeString
    }
    
    func clone() -> UILabel{
        let data = NSKeyedArchiver.archivedData(withRootObject: self)
        return NSKeyedUnarchiver.unarchiveObject(with: data) as! UILabel
    }
    
    func setText(_ pText: String = "", _ pColor: UIColor = .black, _ pFont: UIFont?) {
        self.text = pText
        self.textColor = pColor
        self.font = pFont
    }
    
    func setTextWithHighlight(_ pText: String = "", _ pColor: UIColor = .black, _ pFont: UIFont?, highlightText: [String], highlightColor: [UIColor], highlightFont: [UIFont?], spacing: CGFloat = 2.5, alignment: NSTextAlignment? = nil) {
        
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        paragraphStyle.lineBreakMode = .byTruncatingTail
        if let alignment = alignment {
            paragraphStyle.alignment = alignment
        }
        
        let attributeString = NSMutableAttributedString(string: pText)
        
        attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSAttributedString.Key.font, value: pFont ?? UIFont.systemFont(ofSize: 13), range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: pColor, range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributeString.length))
        
        
        if highlightText.count == highlightColor.count && highlightColor.count == highlightFont.count {
            for index in 0..<highlightText.count {
                let tText = highlightText[index]
                let tColor = highlightColor[index]
                let tFont = highlightFont[index]
                
                if let tRange = pText.range(of: tText) {
                    let nsRange = pText.nsRange(from: tRange)
                    
                    attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: tColor, range:nsRange)
                    attributeString.addAttribute(NSAttributedString.Key.font, value: tFont ?? UIFont.systemFont(ofSize: 13), range:nsRange)
                }
            }
        }
        
        self.attributedText = attributeString
    }
    
    func setTextWithAttribute(_ pText: String = "", _ pColor: UIColor = .black, _ pFont: UIFont?, highlightText: [String] = [], highlightColor: [UIColor] = [], highlightFont: [UIFont?] = [], underlineText: [String] = [], underlineColor: [UIColor] = [], underlineFont: [UIFont?] = [], spacing: CGFloat = 2.5) {
        
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        paragraphStyle.lineBreakMode = .byTruncatingTail
        
        
        let attributeString = NSMutableAttributedString(string: pText)
        
        attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSAttributedString.Key.font, value: pFont ?? UIFont.systemFont(ofSize: 13), range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: pColor, range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributeString.length))
        
        
        if highlightText.count == highlightColor.count && highlightColor.count == highlightFont.count {
            for index in 0..<highlightText.count {
                let tText = highlightText[index]
                let tColor = highlightColor[index]
                let tFont = highlightFont[index]
                
                if let tRange = pText.range(of: tText) {
                    let nsRange = pText.nsRange(from: tRange)
                    
                    attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: tColor, range:nsRange)
                    attributeString.addAttribute(NSAttributedString.Key.font, value: tFont ?? UIFont.systemFont(ofSize: 13), range:nsRange)
                }
            }
        }
        
        if underlineText.count == underlineColor.count && underlineColor.count == underlineFont.count {
            for index in 0..<underlineText.count {
                let tText = underlineText[index]
                let tColor = underlineColor[index]
                let tFont = underlineFont[index]
                
                if let tRange = pText.range(of: tText) {
                    let nsRange = pText.nsRange(from: tRange)
                    
                    attributeString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range:nsRange)
                    attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: tColor, range:nsRange)
                    attributeString.addAttribute(NSAttributedString.Key.font, value: tFont ?? UIFont.systemFont(ofSize: 13), range:nsRange)
                }
            }
        }
        
        self.attributedText = attributeString
        
    }
    
    func setTextWithUnderline(_ pText: String = "", _ pColor: UIColor = .black, _ pFont: UIFont?, highlightText: [String], highlightColor: [UIColor], highlightFont: [UIFont?]) {
        var mMutableString = NSMutableAttributedString()
        
        mMutableString = NSMutableAttributedString(string: pText, attributes: [
            NSAttributedString.Key.font: pFont ?? UIFont.systemFont(ofSize: 13),
            NSAttributedString.Key.foregroundColor: pColor
        ])
        
        if highlightText.count == highlightColor.count && highlightColor.count == highlightFont.count {
            for index in 0..<highlightText.count {
                let tText = highlightText[index]
                let tColor = highlightColor[index]
                let tFont = highlightFont[index]
                
                if let tRange = pText.range(of: tText) {
                    let nsRange = pText.nsRange(from: tRange)
                    
                    mMutableString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range:nsRange)
                    mMutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: tColor, range:nsRange)
                    mMutableString.addAttribute(NSAttributedString.Key.font, value: tFont ?? UIFont.systemFont(ofSize: 13), range:nsRange)
                }
            }
        }
        
        self.attributedText = mMutableString
        
    }
    
}


extension StringProtocol {
    func nsRange(from range: Range<Index>) -> NSRange {
        return .init(range, in: self)
    }
}
