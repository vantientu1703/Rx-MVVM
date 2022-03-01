//
//  String.swift
//  Revival
//
//  Created by phuong.doan on 5/11/21.
//

import Foundation
import UIKit
import RxSwift

extension String {
    func upperCaseFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func upperCaseFirstLetter() {
        self = self.upperCaseFirstLetter()
    }

    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect,
                                            options: .usesLineFragmentOrigin,
                                            attributes: [NSAttributedString.Key.font: font], context: nil)
    
        return ceil(boundingBox.height + font.pointSize * 2)
    }
    
    func isValidEmail() throws -> Bool {
        if self.count == 0 {
            throw NSError(domain: "Email is required", code: 0, userInfo: nil)
        }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if emailPred.evaluate(with: self) {
            return true
        }
        throw NSError(domain: "Please enter a valid email address", code: 0, userInfo: nil)
    }
    
    func isStrengthPassword() throws -> Bool {
        if self.count == 0 {
            throw NSError(domain: "Password is required", code: 0, userInfo: nil)
        }
        let passwrodRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"

        let passwrodPred = NSPredicate(format:"SELF MATCHES %@", passwrodRegEx)
        if passwrodPred.evaluate(with: self) {
            return true
        }
        throw NSError(domain: "At least 8 characters, 1 number, 1 uppercase, 1 lower case, 1 special character", code: 0, userInfo: nil)
    }
    
    func convertToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                Logger.debug(error.localizedDescription)
            }
        }
        return nil
    }
    
//    func toDate() -> Date? {
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = .current
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
//        return dateFormatter.date(from: self)
//    }
//    
//    func toHHMM() -> String {
//        let date = self.toDate() ?? Date()
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = .current
//        dateFormatter.dateStyle = .long
//        dateFormatter.timeStyle = .short
//        dateFormatter.dateFormat = "hh:mm a"
//        return dateFormatter.string(from: date).lowercased()
//    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    /**
     Get name of a class
     
     - parameter aClass: Class
     
     - returns: Class name
     */
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    static func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    static func calculateCalorie(kph: Double, wkg: Double, time: Double) -> Double {
        return (0.0215 * pow(kph, 3) - 0.1765 * pow(kph, 2) + 0.8710 * kph + 1.4577) * wkg * time
    }
    
    func validateCode() throws -> Bool {
        if self.count == 0 {
            throw NSError(domain: "Code is required", code: 0, userInfo: nil)
        }
        if self.count > 6 {
            throw NSError(domain: "Invalid code", code: 0, userInfo: nil)
        }
        return true
    }
    
    func validateName() throws -> Bool {
        if self.count < 1 {
            throw NSError(domain: "is required.", code: 1, userInfo: nil)
        }
        if self.count > 35 {
            throw NSError(domain: "must be maximum 35 characters long", code: 2, userInfo: nil)
        }
        let regex = "^[A-Za-z- '.0-9]{0,35}$"
        
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        if predicate.evaluate(with: self) {
            return true
        }
        throw NSError(domain: "Only Alphanumeric and following special characters -.' are allowed", code: 3, userInfo: nil)
    }
    
    func validatePhone() throws -> Bool {
        if self.count < 1 {
            throw NSError(domain: "Phone number is required.", code: 0, userInfo: nil)
        }
        let regex = "[0-9]{7,15}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        
        if predicate.evaluate(with: self) {
            return true
        } else {
            throw NSError(domain: "Phone number must be between 7 and 15 digits", code: 0, userInfo: nil)
        }
    }
    
    func validateAddress() throws -> Bool {
        if self.count < 1 {
            throw NSError(domain: "Street address is required.", code: 0, userInfo: nil)
        }
        
        if self.count > 40 {
            throw NSError(domain: "Street address must be maximum 40 characters long.", code: 0, userInfo: nil)
        }
        return true
    }
    
    func validateCity() throws -> Bool {
        if self.count < 1 {
            throw NSError(domain: "City is required.", code: 0, userInfo: nil)
        }
        
        if self.count > 35 {
            throw NSError(domain: "City must be maximum 35 characters long.", code: 0, userInfo: nil)
        }
        return true
    }
    
    func validateWaistWeight() throws -> Bool {
        if self.count < 1 {
            throw NSError(domain: "is required.", code: 0, userInfo: nil)
        }
        
        let regex = "^(?:[0-9]{1,3}|[0-9]{1,3}([.][0-9]{1,2}))$"
//        if self.count < 7, let _ = Float(self) {
//            return true
//        }
        let preciate = NSPredicate(format: "SELF MATCHES %@", regex)
        if preciate.evaluate(with: self) {
            return true
        }
        throw NSError(domain: "must be maximum 3 digits, 2 decimals", code: 0, userInfo: nil)
    }
    
    func validateZipCode() throws -> Bool {
        if self.count < 1 {
            throw NSError(domain: "Zip code is required.", code: 0, userInfo: nil)
        }
        if (self.count == 5 || self.count == 9), let _ = Int(self) {
            return true
        } else {
            throw NSError(domain: "Zip code must be 5 or 9 digits.", code: 0, userInfo: nil)
        }
    }
    
    func setTextWithHighlight(_ pColor: UIColor, _ pFont: UIFont?, highlightText: [String], highlightColor: [UIColor], highlightFont: [UIFont?], spacing: CGFloat = 2.5, alignment: NSTextAlignment? = nil) -> NSAttributedString {
        
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        paragraphStyle.lineBreakMode = .byTruncatingTail
        if let alignment = alignment {
            paragraphStyle.alignment = alignment
        }
        
        let attributeString = NSMutableAttributedString(string: self)
        
        attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSAttributedString.Key.font, value: pFont ?? UIFont.systemFont(ofSize: 13), range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: pColor, range: NSMakeRange(0, attributeString.length))
        attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributeString.length))
        
        
        if highlightText.count == highlightColor.count && highlightColor.count == highlightFont.count {
            for index in 0..<highlightText.count {
                let tText = highlightText[index]
                let tColor = highlightColor[index]
                let tFont = highlightFont[index]
                
                if let tRange = self.range(of: tText) {
                    let nsRange = self.nsRange(from: tRange)
                    
                    attributeString.addAttribute(NSAttributedString.Key.foregroundColor, value: tColor, range:nsRange)
                    attributeString.addAttribute(NSAttributedString.Key.font, value: tFont ?? UIFont.systemFont(ofSize: 13), range:nsRange)
                }
            }
        }
        
        return attributeString
    }
    
    func highlightTexts(_ highlighTexts: [HighLightText]) -> NSAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        highlighTexts.forEach { content in
            let range = (self as NSString).range(of: content.text)
            attributeString.addAttributes(content.attributte, range: range)
        }
        return attributeString
    }
    
    func highlightText(_ highlightText: String, attribute: [NSAttributedString.Key: Any]) -> NSAttributedString {
        let attriString = NSMutableAttributedString(string: self)
        let range = (self as NSString).range(of: highlightText)
        attriString.addAttributes(attribute, range: range)
        return attriString
    }
    
    struct HighLightText {
        let text: String
        let attributte: [NSAttributedString.Key: Any]
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8),
              self.count > 0 else {
            return nil
        }
        do {
            return try NSAttributedString(data: data,
                                          options: [.documentType: NSAttributedString.DocumentType.html,
                                                    .characterEncoding: String.Encoding.utf8.rawValue],
                                          documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
    var htmlToString: String? {
        return htmlToAttributedString?.string
    }
    
    func string(startIndex: Int, endIndex: Int) -> String {
        return ""
    }
    
    enum CardType: String, CaseIterable {
        case Unknown, Amex, Visa, MasterCard, Diners, Discover, JCB, Elo, Hipercard, UnionPay
        
        static let allCards = [Amex, Visa, MasterCard, Diners, Discover, JCB, Elo, Hipercard, UnionPay]
        
        var regex : String {
            switch self {
            case .Amex:
                return "^3[47][0-9]{5,}$"
            case .Visa:
                return "^4[0-9]{6,}([0-9]{3})?$"
            case .MasterCard:
                return "^(5[1-5][0-9]{4}|677189)[0-9]{5,}$"
            case .Diners:
                return "^3(?:0[0-5]|[68][0-9])[0-9]{4,}$"
            case .Discover:
                return "^6(?:011|5[0-9]{2})[0-9]{3,}$"
            case .JCB:
                return "^(?:2131|1800|35[0-9]{3})[0-9]{3,}$"
            case .UnionPay:
                return "^(62|88)[0-9]{5,}$"
            case .Hipercard:
                return "^(606282|3841)[0-9]{5,}$"
            case .Elo:
                return "^((((636368)|(438935)|(504175)|(451416)|(636297))[0-9]{0,10})|((5067)|(4576)|(4011))[0-9]{0,12})$"
            default:
                return ""
            }
        }
        
        var image: UIImage? {
            switch self {
            case .Amex: return UIImage(named: "ic_card_amex")
            case .Visa: return UIImage(named: "ic_card_visa")
            case .MasterCard: return UIImage(named: "ic_card_mastercard")
            case .Diners: return UIImage(named: "ic_card_diners")
            case .Discover: return UIImage(named: "ic_card_discover")
            case .JCB: return UIImage(named: "ic_card_jcb")
            case .UnionPay: return UIImage(named: "ic_card_unionpay")
            case .Hipercard: return UIImage(named: "ic_card_unknown_icon")
            case .Elo: return UIImage(named: "ic_card_unknown_icon")
            case .Unknown: return UIImage(named: "ic_card_unknown_icon")
            }
        }
    }
    
    func matchesRegex(regex: String, text: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [.caseInsensitive])
            let nsString = text as NSString
            let match = regex.firstMatch(in: text, options: [], range: NSMakeRange(0, nsString.length))
            return (match != nil)
        } catch {
            return false
        }
    }
    
    func luhnCheck(number: String) -> Bool {
        var sum = 0
        // number.index(from: 1)
        // let digitStrings = number.characters.reversed().map { String($0) }
        let digitStrings = number.characters().reversed()
        for tuple in digitStrings.enumerated() {
            guard let digit = Int(tuple.element) else { return false }
            // let odd = tuple.index % 2 == 1
            let odd = tuple.offset % 2 == 1
            switch (odd, digit) {
            case (true, 9):
                sum += 9
            case (true, 0...8):
                sum += (digit * 2) % 9
            default:
                sum += digit
            }
        }

        return sum % 10 == 0
    }

    func checkCardNumber() -> (type: CardType, formatted: String, valid: Bool) {
        // Get only numbers from the input string
        // let numberOnly = input.stringByReplacingOccurrencesOfString("[^0-9]", withString: "", options: .RegularExpressionSearch)
        let numberOnly = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        var type: CardType = .Unknown
        var formatted = ""
        var valid = false

        // detect card type
        for card in CardType.allCards {
            if (matchesRegex(regex: card.regex, text: numberOnly)) {
                type = card
                break
            }
        }

        // format
        var formatted4 = ""
        
        for character in numberOnly.characters() {
            if formatted4.count == 4 {
                formatted += formatted4 + " "
                formatted4 = ""
            }
            formatted4.append(character)
        }
        formatted += formatted4 // the rest
        // check validity
        valid = luhnCheck(number: numberOnly)
        // return the tuple
        return (type, formatted, valid)
    }
    
    func isExpiredDate() -> Bool {
        let date = self.toDate(format: .MMyy, formatter: .currentTimezone)
        return date?.isExpired() ?? true
    }
    
    func checkExpiredDateFormat() -> (formatted: String, isExpired: ValidDateType) {
        let numberOnly = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let characters = numberOnly.characters()
        var formatted = ""
        var format2 = ""
        for c in characters {
            if format2.count == 2 {
                formatted += format2 + "/"
                format2 = ""
            }
            format2.append(c)
        }
        formatted += format2
        var validDate: ValidDateType = .expired
        if formatted.isValidDate() {
            validDate = formatted.isExpiredDate() ? .expired : .valid
        } else {
            validDate = .invalid
        }
        return (formatted, validDate)
    }
    
    func isValidDate() -> Bool {
        if let _ = self.toDate(format: .MMyy, formatter: .currentTimezone) {
            return true
        }
        return false
    }
     
    enum ValidDateType {
        case valid
        case expired
        case invalid
    }
    
    func toObject<T: Decodable>() -> T? {
        guard let data = self.data(using: .utf8, allowLossyConversion: false) else { return nil }
        return try? JSONDecoder().decode(T.self, from: data)
    }
}

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }
    func substring(to: Int) -> String {
        if to < self.count {
            let toIndex = index(from: to)
            return String(self[..<toIndex])
        }
        return self
    }
    func substring(with r: Range<Int>) -> String {
        if self.count < r.upperBound {
            return ""
        }
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
    
    func character(at index: Int) -> String? {
        if 1 <= index && index <= self.count {
            let startIndex = self.index(self.startIndex, offsetBy: index - 1)
            let endIndex = self.index(self.startIndex, offsetBy: index)
            return String(self[startIndex..<endIndex])
        }
        return nil
    }
    
    func characters() -> [String] {
        if self.count <= 0 {
            return []
        }
        var strings: [String?] = []
        for index in 1...self.count {
            strings.append(self.character(at: index))
        }
        return strings.compactMap { $0 }
    }
}
