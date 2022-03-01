//
//  UserDefaults+Ext.swift
//  RevivalPatient
//
//  Created by nguyen minh tuan on 07/12/2021.
//

import Foundation

extension UserDefaults {
    func set<T: Codable>(value data: T, forKey key: String) {
        guard let data = try? JSONEncoder().encode(data) else {
            return
        }
        UserDefaults.standard.setValue(data, forKey: key)
        UserDefaults.standard.synchronize()
    }
    func set<T: Codable>(value data: [T], forKey key: String) {
        guard let data = try? JSONEncoder().encode(data) else {
            return
        }
        UserDefaults.standard.setValue(data, forKey: key)
        UserDefaults.standard.synchronize()
    }
    func objectForKey<T: Codable>(_ key: String) -> [T]? {
        guard let data = UserDefaults.standard.object(forKey: key) as? Data else {
            return nil
        }
        return try? JSONDecoder().decode([T].self, from: data)
    }
    
    func objectForKey<T: Codable>(_ key: String) -> T? {
        guard let data = UserDefaults.standard.object(forKey: key) as? Data else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
