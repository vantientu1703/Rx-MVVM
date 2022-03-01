//
//  Decodable+Ext.swift
//  RevivalPatient
//
//  Created by nguyen minh tuan on 13/12/2021.
//

import Foundation

extension Decodable {
    static func map(JSONString:String) -> Self? {
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(Self.self, from: Data(JSONString.utf8))
        } catch let error {
            Logger.debug(error)
            return nil
        }
    }
    /*
     if let dict = JSONString.convertToDictionary() {
         do {
             let data = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
             let decoder = JSONDecoder()
             return try decoder.decode(Self.self, from: data)
         } catch {
             Logger.debug(error.localizedDescription)
             return nil
         }
     }
     return nil
     */
}
