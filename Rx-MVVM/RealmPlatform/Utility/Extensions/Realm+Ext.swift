
import Foundation
import Realm
import RealmSwift
import RxSwift

extension Object {
    static func build<O: Object>(_ builder: (O) -> () ) -> O {
        let object = O()
        builder(object)
        return object
    }
}

extension Realm {
    func save<R: RealmRepresentable>(entity: R, update: Bool = true) -> Observable<R.RealmType> where R.RealmType: Object  {
        return Observable.create { observer in
            self.safeWrite {
                self.add(entity.asRealm(), update: .all)
            }
            observer.onNext(entity.asRealm())
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func save<R: RealmRepresentable>(entities: [R], update: Bool = true) -> Observable<[R.RealmType]> where R.RealmType: Object  {
        return Observable.create { observer in
            let items = entities.map({ $0.asRealm() })
            self.safeWrite {
                self.add(items, update: .all)
            }
            observer.onNext(items)
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func delete<R: RealmRepresentable>(entity: R) -> Observable<Void> where R.RealmType: Object {
        return Observable.create { observer in
            guard let object = self.object(ofType: R.RealmType.self, forPrimaryKey: entity.uid) else {
                return Disposables.create()
            }
            self.safeWrite {
                self.delete(object)
            }
            observer.onNext(())
            observer.onCompleted()
            return Disposables.create()
        }
    }
    
    func delete<R: RealmRepresentable>(entities: [R]) -> Observable<Void> where R.RealmType: Object {
        return Observable.create { observer in
            let items = entities.compactMap({ object -> Object? in
                return self.object(ofType: R.RealmType.self, forPrimaryKey: object.uid)
            })
            self.safeWrite {
                self.delete(items)
            }
            observer.onNext(())
            observer.onCompleted()
            return Disposables.create()
        }
    }
}
