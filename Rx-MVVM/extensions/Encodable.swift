//
//  Encodable.swift
//  Revival
//
//  Created by DoanDuyPhuong on 27/04/2021.
//

import Foundation

extension Encodable {
    func asDictionary()  -> [String: Any]? {
        do {
            let data = try JSONEncoder().encode(self)
            let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
            return dictionary
        }
        catch {
            return nil
        }
    }
}
