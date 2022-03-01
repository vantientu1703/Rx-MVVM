//
//  UNLocalNotification.swift
//  RevivalPatient
//
//  Created by Tu Van on 08/02/2022.
//

import UserNotifications

extension UNUserNotificationCenter {
    static func sendNowNotification(body: String, completion: (() -> ())?) {
        let content      = UNMutableNotificationContent()
        content.body    = body
        content.sound    = .default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            guard error == nil else { return }
        }
    }
}
