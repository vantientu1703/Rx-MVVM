//
//  RMService.swift
//  Chiti
//
//  Created by Văn Tiến Tú on 10/31/20.
//  Copyright © 2020 Văn Tiến Tú. All rights reserved.
//

import Realm
import RealmSwift
import RxSwift
import RxRelay
import Darwin

let databaseVersion: UInt64 = 0

typealias RMServiceProtocol = ContentModelUseCaseProtocol

class RMService: RMServiceProtocol {
    
    static var defaultConfiguration: Realm.Configuration {
        return Realm.Configuration(fileURL: self.storageLocation,
                                   schemaVersion: databaseVersion,
                                   migrationBlock: nil)
    }

    private static var storageLocation: URL? {
        return Realm.Configuration.defaultConfiguration.fileURL
    }

    private let provider: UseCaseProviderProtocol
    let contentModelUseCaseProtocol: ContentModelUseCaseProtocol

    init(configuration: Realm.Configuration = RMService.defaultConfiguration) {
        self.provider = UseCaseProvider(configuration: configuration)
        self.contentModelUseCaseProtocol = self.provider.makeContentModelUseCase()
    }
    
    func save(contents: [ContentModel]) -> Single<Void> {
        self.contentModelUseCaseProtocol.save(contents: contents)
    }
    
    func getContents() -> Single<[ContentModel]> {
        return self.contentModelUseCaseProtocol.getContents()
    }
    
    func delete(contents: [ContentModel]) -> Single<Void> {
        self.contentModelUseCaseProtocol.delete(contents: contents)
    }
}
