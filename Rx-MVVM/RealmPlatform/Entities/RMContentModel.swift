//
//  RMDatum.swift
//  RevivalPatient
//
//  Created by Tu Van on 18/02/2022.
//
import Realm
import RealmSwift

class RMContentModel: Object {
    @objc @Persisted(primaryKey: true) var id: String?
    @Persisted var content: String?
}

extension RMContentModel: DomainConvertibleType {
    func asDomain() -> ContentModel {
        let model = ContentModel()
        model.id = self.id
        model.content = self.content
        return model
    }
}
