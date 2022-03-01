//
//  Date.swift
//  Revival
//
//  Created by thuan.nguyen on 28/04/2021.
//

import UIKit

enum DateFormat: String {
    case yyyymmdd = "yyyy-MM-dd"
    case ddmmyyyy1 = "dd-MM-yyyy"
    case ddmmyyyy2 = "dd/MM/yyyy"
    case mmddyyyy = "MM/dd/yyyy"
    case full = "HH:mm:ss - yyyy-MM-dd"
    case eemmddyy = "EEEE, MMM-dd-yyyy"
    case yyyy = "yyyy"
    case MMMdyyyy = "MMM d, yyyy"
    case MMMdyyyyHHmmss = "MMM d, yyyy HH:mm:ss"
    case dd = "dd"
    case MM = "MM"
    case MMdd = "MM/dd"
    case MMMdd = "MMM dd"
    case yyyyMMddHHmmssZ = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    case yyyyMMddTHHmmssSSSSSSS = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS"
    case hhmma = "HH:mm a"
    case yyyyMMddTHHmmssSSS = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    case yyyyMMddTHHmmss = "yyyy-MM-dd'T'HH:mm:ss"
    case yyyyMMddTHHmmssZZ = "yyyy-MM-dd'T'HH:mm:ssZ"
    case HH = "HH"
    case EE = "EE"
    case MMMddyyyy = "MMM dd, yyyy"
    case MMddyyyyhhmma = "MM/dd/yyyy - hh:mm:ss a"
    case hhmmssa = "HH:mm:ss a"
    case ddMMyyyyhhmma = "dd/MM/yyy - hh:mm:ss a"
    case yyyyMMddHHmmss = "yyyyMMddHHmmss"
    case MMyy = "MM/yy"
    case uploadFormat = "yyyy-MM-dd__HH-mm-ss-SSS"
    case hhmmssSSS = "hh-mm-ss-SSS"
    
    func stringFromDate(date: Date, formatter: UsingFormatter = .currentTimezone) -> String {
        let dateFormatter = formatter.formatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = self.rawValue
        return dateFormatter.string(from: date)
    }
    func dateFromString(date: String, formatter: UsingFormatter = .currentTimezone) -> Date? {
        let dateFormatter = formatter.formatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = self.rawValue
        return dateFormatter.date(from: date)
    }
    
}

enum UsingFormatter {
    case timezoneGMT0
    case currentTimezone
    
    func formatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        switch self {
        case .timezoneGMT0:
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
        case .currentTimezone:
            formatter.timeZone = .current
        }
        return formatter
    }
}

extension String {
    func toDate(format: DateFormat, formatter: UsingFormatter = .currentTimezone) -> Date? {
        return format.dateFromString(date: self, formatter: formatter)
    }
    func toDate(format: String, formatter: UsingFormatter = .currentTimezone) -> Date? {
        return dateFromString(date: self, format: format, formatter: formatter)
    }
    func dateFromString(date: String, format: String, formatter: UsingFormatter = .currentTimezone) -> Date? {
        let dateFormatter = formatter.formatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: date)
    }
}

extension Date {
    
    func periodDay(component: Calendar.Component, value: Int) -> Date? {
        let earlyDate = Calendar.current.date(byAdding: component, value: value, to: self)
        return earlyDate
    }
    
    func toString(format: DateFormat, formatter: UsingFormatter = .currentTimezone) -> String {
        return format.stringFromDate(date: self, formatter: formatter)
    }
    
    var milliseconds: Int {
        return Int((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds: Int) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
    
    func available13YearOlds() -> Bool {
        let years = Calendar.current.dateComponents([.year], from: self, to: Date()).year
        return years ?? 0 >= 13
    }
    
    func componentYear() -> Int {
        let years = Calendar.current.component(.year, from: self)
        return years
    }
    
    func calculateYearsOld() -> Int {
        let years = Calendar.current.dateComponents([.year], from: self, to: Date()).year
        return years ?? 0
    }
    
    func getHours(from date: Date?) -> Int {
        guard let date = date else { return 0 }
        let components = Calendar.current.dateComponents([.hour, .minute], from: date, to: self)
        if let hour = components.hour, let minute = components.minute {
            if minute > 0 {
                return hour + 1
            }
            return hour
        }
        return components.hour ?? 0
    }
    
    static var currentYear: Int {
        get {
            if let year = Int(DateFormat.yyyy.stringFromDate(date: Date())) {
                return year
            }
            return 2021
        }
    }
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }
    
    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
    func isBetween(_ date1: Date, and date2: Date) -> Bool {
        return (min(date1, date2) ... max(date1, date2)).contains(self)
    }
    func inRange(_ date1: Date?, and date2: Date?) -> Bool {
        if let date1 = date1, let date2 = date2 {
            return (min(date1, date2) ... max(date1, date2)).contains(self)
        }else if let date1 = date1 {
            return self >= date1
        }else if let date2 = date2 {
            return self <= date2
        }
        return true
    }
    static func compare(_ date1: Date?, and date2: Date?) -> Bool {
         if date1 == nil && date2 != nil {
            return true
        }else if let date1 = date1, let date2 = date2 {
            return date1 < date2
        }
        return false
    }
    
    func isExpired() -> Bool {
        if self.compare(Date()) == .orderedAscending {
            return true
        }
        return false
    }
}
