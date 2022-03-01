//
//  Realm.swift
//  RevivalPatient
//
//  Created by phuong.doan on 5/29/21.
//

import Foundation
import RealmSwift

extension Realm {
    public func safeWrite(_ block: (() throws -> Void)) {
        if isInWriteTransaction == true {
            try! block()
        } else {
            try! write(block)
        }
    }
}
