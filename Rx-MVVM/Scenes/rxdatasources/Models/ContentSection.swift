//
//  ContentSection.swift
//  Rx-MVVM
//
//  Created by Tu Van on 08/03/2022.
//

import Foundation

enum ContentSection {
    case section(title: String, items: [ContentItem])
}

enum ContentItem {
    case content(item: ContentModel)
}

extension ContentSection: RPAnimatableSectionModelType {
    typealias Item = ContentItem
    typealias Identity = String
    
    var identity: String {
        switch self {
        case .section(let title, _):
            return title
        }
    }
    var items: [ContentItem] {
        switch self {
        case .section(_, let items):
            return items
        }
    }
    
    init(original: ContentSection, items: [ContentItem]) {
        switch original {
        case .section(let title, _):
            self = .section(title: title, items: items)
        }
    }
}

extension ContentItem: RPIdentifiableType, Equatable {
    typealias Identity = String
    
    var identity: ContentItem.Identity {
        switch self {
        case .content(let item):
            return item.id ?? UUID().uuidString
        }
    }
    
    var objectId: String {
        switch self {
        case .content(let item):
            return item.id ?? UUID().uuidString
            
        }
    }
    
    static func ==(lhs: ContentItem, rhs: ContentItem) -> Bool {
        return lhs.identity == rhs.identity
    }
}


