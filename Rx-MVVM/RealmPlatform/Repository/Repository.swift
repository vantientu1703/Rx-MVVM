import Foundation
import Realm
import RealmSwift
import RxSwift

protocol AbstractRepository {
    associatedtype T
    func queryAll(sortedByKeyPath keyPath: String?, ascending: Bool) -> Observable<[T]>
    func query(with predicate: NSPredicate, sortedByKeyPath keyPath: String?, ascending: Bool) -> Observable<[T]>
    func save(entity: T) -> Observable<Void>
    func save(entities: [T]) -> Observable<Void>
    func delete(entity: T) -> Observable<Void>
    func delete(entities: [T]) -> Observable<Void>
}

final class Repository<T:RealmRepresentable>: AbstractRepository where T == T.RealmType.DomainType, T.RealmType: Object {
    
    private let configuration: Realm.Configuration
    
    private lazy var scheduler: ConcurrentMainScheduler = {
        let schedule = ConcurrentMainScheduler.instance
        return schedule
    }()

    private var realm: Realm {
        return try! Realm(configuration: self.configuration)
    }
    
    init(configuration: Realm.Configuration) {
        self.configuration = configuration
        Logger.debug("File 📁 url: \(RLMRealmPathForFile("default.realm"))")
    }
    
    deinit {
        Logger.debug("deinited - Repository - AbstractRepository")
    }

    func queryAll(sortedByKeyPath keyPath: String?, ascending: Bool) -> Observable<[T]> {
        return Observable<[T]>.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            var objects = self.realm.objects(T.RealmType.self)
            if let keyPath = keyPath {
                objects = objects.sorted(byKeyPath: keyPath, ascending: ascending)
            }
            
            observer.onNext(objects.mapToDomain())
            observer.onCompleted()
            return Disposables.create()
        }
        .subscribe(on: self.scheduler)
    }

    func query(with predicate: NSPredicate, sortedByKeyPath keyPath: String?, ascending: Bool) -> Observable<[T]> {
        return Observable<[T]>.create { [weak self] observer in
            guard let self = self else { return Disposables.create() }
            var objects = self.realm.objects(T.RealmType.self)
                .filter(predicate)
            if let keyPath = keyPath {
                objects = objects.sorted(byKeyPath: keyPath, ascending: ascending)
            }
            
            observer.onNext(objects.mapToDomain())
            observer.onCompleted()
            return Disposables.create()
        }
        .subscribe(on: self.scheduler)
    }

    func save(entity: T) -> Observable<Void> {
        return Observable.just(entity)
            .flatMap({ [weak self] obj -> Observable<Void> in
                guard let self = self else { return .empty() }
                return self.realm.save(entity: obj).mapToVoid()
            })
            .subscribe(on: self.scheduler)
    }
    
    func save(entities: [T]) -> Observable<Void> {
        return Observable.just(entities)
            .flatMap({ [weak self] items -> Observable<Void> in
                guard let self = self else { return .empty() }
                return self.realm.save(entities: items).mapToVoid()
            })
            .mapToVoid()
            .subscribe(on: self.scheduler)
    }

    func delete(entity: T) -> Observable<Void> {
        return Observable.from(optional: entity)
            .flatMap { [weak self] obj -> Observable<Void> in
                guard let self = self else { return .empty() }
                return self.realm.delete(entity: obj).mapToVoid()
            }
            .subscribe(on: self.scheduler)
    }
    
    func delete(entities: [T]) -> Observable<Void> {
        return Observable.just(entities)
            .flatMap { [weak self] items -> Observable<Void> in
                guard let self = self else { return .empty() }
                return self.realm.delete(entities: items)
            }
            .subscribe(on: self.scheduler)
    }
}
