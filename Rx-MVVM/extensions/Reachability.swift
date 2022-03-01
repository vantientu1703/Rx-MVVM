// The MIT License (MIT)
//
// Copyright (c) 2017 Alexander Grebenyuk (github.com/kean).

import Foundation
import Alamofire
import RxSwift
import RxCocoa


final class MReachability {
//    static var shared: Reachability {
//        return Reachability.shared.reachability
//    }
    static let shared = MReachability()
    /// Monitors general network reachability.
    let reachability = NetworkReachabilityManager()

    var didBecomeReachable: Signal<Void> { return _didBecomeReachable.asSignal() }
    private let _didBecomeReachable = PublishRelay<Void>()

    init() {
//        self.isReachable = _isReachable.asDriver()

        if let reachability = self.reachability {
            reachability.startListening { [weak self] result in
                self?.update(result)
            }
        }
    }

    private func update(_ status: NetworkReachabilityManager.NetworkReachabilityStatus) {
        if case .reachable = status {
            _didBecomeReachable.accept(())
        }
    }
}
