//
//  ContentModel.swift
//  Rx-MVVM
//
//  Created by Tu Van on 01/03/2022.
//

import Foundation

class ContentModel: Codable {
    var id: String?
    var content: String?
}

extension ContentModel: RealmRepresentable {
    var uid: String {
        return self.id ?? UUID().uuidString
    }
    
    func asRealm() -> some RMContentModel {
        return RMContentModel.build { object in
            object.id = self.id
            object.content = self.content
        }
    }
}
