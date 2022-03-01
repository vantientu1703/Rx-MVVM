//
//  Dictionary.swift
//  RevivalPatient
//
//  Created by phuong.doan on 5/29/21.
//

import Foundation

extension Dictionary {
    var data: Data? {
        get {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
                return jsonData
            }
            catch {
                return nil
            }
        }
    }
}

extension JSONDecoder {
    func map<T: Decodable>(_ type: T.Type, from dict: [String: Any]) -> T? {
        if let data = dict.data {
            do {
                let object = try decode(T.self, from: data)
                return object
            }
            catch {
                return nil
            }
        }
        return nil
    }
}
