//
//  UseCaseProvider.swift
//  Chiti
//
//  Created by Văn Tiến Tú on 10/31/20.
//  Copyright © 2020 Văn Tiến Tú. All rights reserved.
//

import UIKit

import Foundation
import Realm
import RealmSwift

protocol UseCaseProviderProtocol {
     func makeContentModelUseCase() -> ContentModelUseCaseProtocol
}

final class UseCaseProvider: UseCaseProviderProtocol {
    private let configuration: Realm.Configuration

    init(configuration: Realm.Configuration = Realm.Configuration()) {
        self.configuration = configuration
    }

    func makeContentModelUseCase() -> ContentModelUseCaseProtocol {
        let repository = Repository<ContentModel>(configuration: configuration)
        return ContentModelUseCase(repository: repository)
    }
}
