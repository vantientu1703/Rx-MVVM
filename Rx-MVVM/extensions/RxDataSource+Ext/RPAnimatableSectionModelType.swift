//
//  AVGAnimatedSectionType.swift
//  AVG
//
//  Created by Van Tien Tu on 11/20/20.
//  Copyright © 2020 SonDH. All rights reserved.
//

import UIKit
import RxDataSources

protocol RPIdentifiableType: IdentifiableType {
    var objectId: String { get }
}

protocol RPAnimatableSectionModelType: AnimatableSectionModelType where Item: RPIdentifiableType {
    
}

extension Array where Element: RPIdentifiableType {
    func first(byId id: String) -> Element? {
        return self.first { $0.objectId == id }
    }
    
    func firstIndex(byId id: String) -> Int? {
        return self.firstIndex { $0.objectId == id }
    }
}

extension Array where Element: RPAnimatableSectionModelType  {
    func indexPath(byId id: String) -> IndexPath? {
        for section in self.enumerated() {
            if let firstIndex = section.element.items.firstIndex(byId: id) {
                return IndexPath(row: firstIndex, section: section.offset)
            }
        }
        return nil
    }
    
    func hasItems() -> Bool {
        for section in self {
            if section.items.count > 0 {
                return true
            }
        }
        return false
    }
}
