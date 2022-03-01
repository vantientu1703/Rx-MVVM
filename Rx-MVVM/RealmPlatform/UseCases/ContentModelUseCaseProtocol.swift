import Foundation
import RxSwift
import Realm
import RealmSwift

protocol ContentModelUseCaseProtocol {
    func save(contents: [ContentModel]) -> Single<Void>
    func getContents() -> Single<[ContentModel]>
    func delete(contents: [ContentModel]) -> Single<Void>
}

final class ContentModelUseCase<Repository>: ContentModelUseCaseProtocol where Repository: AbstractRepository, Repository.T == ContentModel {

    private let repository: Repository

    init(repository: Repository) {
        self.repository = repository
    }

    func save(contents: [ContentModel]) -> Single<Void> {
        return self.repository.save(entities: contents).asSingle()
    }

    func getContents() -> Single<[ContentModel]> {
        return self.repository.queryAll(sortedByKeyPath: nil, ascending: true).asSingle()
    }

    func delete(contents: [ContentModel]) -> Single<Void> {
        return self.repository.delete(entities: contents).asSingle()
    }
}
