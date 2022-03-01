//
//  BaseViewController.swift
//  RevivalPatient
//
//  Created by phuong.doan on 5/26/21.
//

import Foundation
import UIKit
import RxSwift
import SnapKit
import Kingfisher
import NVActivityIndicatorView

class BaseViewController: UIViewController {
    
    private var rightBarButton: UIBarButtonItem!
    private var leftBarButton: UIBarButtonItem!
    
    lazy var refreshControl = UIRefreshControl()
    
    let disposeBag = DisposeBag()
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    private let imageView = UIImageView()
    
    private lazy var loadingView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private lazy var indicatorView: NVActivityIndicatorView = {
        let view = NVActivityIndicatorView(frame: CGRect(origin: .zero,
                                                         size: CGSize(width: 40, height: 40)),
                                           type: .ballClipRotate,
                                           color: .lightGray,
                                           padding: 10)
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Logger.debug("🔴 🔴 🔴  [inited] --> \(self.identifierString)")
        if #available(iOS 13.0, *) {
            let navBarApperence = UINavigationBarAppearance()
            navBarApperence.backgroundColor = .white
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.standardAppearance = navBarApperence
            navigationController?.navigationBar.scrollEdgeAppearance = navBarApperence
        } else {
            // Fallback on earlier versions
        }
        refreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
    }
    
    @objc func refreshAction() {
        
    }
    
    func showLoading(from viewModel: BaseViewModel) {
        viewModel.showLoading
            .subscribe(onNext: { [weak self] isShow in
                self?.showIndciator(isShow: isShow)
            })
            .disposed(by: self.disposeBag)
    }
    
    func showIndciator(isShow: Bool) {
        if isShow {
            self.startAnimatingIndicator()
        } else {
            self.stopAnimatingIndicator()
        }
    }
    
    func startAnimatingIndicator() {
        self.view.addSubview(self.loadingView)
        self.loadingView.addSubview(self.indicatorView)
        self.indicatorView.startAnimating()
        
        self.loadingView.snp.makeConstraints { maker in
            maker.left.bottom.right.top.equalToSuperview()
        }
        self.indicatorView.snp.makeConstraints { [unowned self] maker in
            maker.width.equalTo(60)
            maker.height.equalTo(60)
            maker.center.equalTo(self.loadingView.snp.center)
        }
    }
    
    func stopAnimatingIndicator() {
        self.indicatorView.stopAnimating()
        self.loadingView.removeFromSuperview()
    }
    
    @objc func closeAction(animated: Bool = true, completion: (() -> ())? = nil) {
        if let tabBarController = tabBarController {
            tabBarController.dismiss(animated: animated, completion: completion)
        }
        else if let navigationController = navigationController {
            navigationController.dismiss(animated: animated, completion: completion)
        }
        else {
            dismiss(animated: animated, completion: completion)
        }
    }
    @objc func backAction(animated: Bool = true, completion: (() -> ())? = nil) {
        if let navigationController = navigationController {
            let viewControllers = navigationController.viewControllers
            if viewControllers.count > 1 {
                navigationController.popViewController(animated: animated)
                completion?()
            } else {
                navigationController.dismiss(animated: animated, completion: completion)
            }
        } else {
            self.dismiss(animated: animated, completion: completion)
        }
    }
    
    deinit {
        
    }
}
