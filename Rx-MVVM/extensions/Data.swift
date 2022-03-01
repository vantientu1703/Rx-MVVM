//
//  Data.swift
//  RevivalPatient
//
//  Created by Vang Doan on 18/06/2021.
//

import Foundation

extension Data {
    var prettyPrintedJSONString: String? { 
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = String(data: data, encoding: .utf8) else { return nil }

        return prettyPrintedString.replacingOccurrences(of: "\n", with: "")
    }
}
