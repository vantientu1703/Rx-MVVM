//
//  UIStoryboard+Ext.swift
//  BaseProject
//
//  Created by Văn Tiến Tú on 11/7/18.
//  Copyright © 2018 Văn Tiến Tú. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
    enum StoryboardName: String {
        
        case launch
        case authentication
        case splash
        case createAccount
        case clinicalRecord
        case financials
        case medications
        case bills
        case doctorAndHospitalVisits
        case nutritionDetail
        case select
        case alert
        case prescriptions
        case checkout
        case subscriptions
        case billHistory
        case careHistory
        case authorizeNet
        
        var identifierString: String {
            switch self {
            case .splash:
                return "Move78Splash"
            case .launch:
                return "Launch"
            case .authentication:
                return "Authentication"
            case .createAccount:
                return "CreateAccount"
            case .clinicalRecord:
                return "ClinicalRecords"
            case .financials:
                return "Financials"
            case .medications:
                return "Medications"
            case .bills:
                return "Bills"
            case .doctorAndHospitalVisits:
                return "DoctorAndHospitalVisits"
            case .nutritionDetail:
                return "NutritionDetail"
            case .select:
                return "Select"
            case .alert:
                return "Alert"
            case .prescriptions:
                return "Prescriptions"
            case .checkout:
                return "Checkout"
            case .subscriptions: return "Subscriptions"
            case .billHistory: return "BillHistory"
            case .careHistory: return "CareHistory"
            case .authorizeNet: return "AuthorizeNet"
            }
        }
    }
    
    convenience init(storyboard: StoryboardName, bundle: Bundle? = nil) {
        self.init(name: storyboard.identifierString, bundle: bundle)
    }
    
    class func storyboard(_ storyboard: StoryboardName, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.identifierString, bundle: bundle)
    }
    
    func instantiateViewController<T: UIViewController>(_ type: T.Type) -> T? {
        return instantiateViewController(withIdentifier: type.identifierString) as? T
    }
}
