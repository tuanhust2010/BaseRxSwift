//
//  BaseViewController.swift
//  BaseRxSwift
//
//  Created by nguyen.manh.tuanb on 27/02/2019.
//  Copyright © 2019 nguyen.manh.tuanb. All rights reserved.
//

import UIKit
import RxSwift
import NVActivityIndicatorView

class BaseViewController: UIViewController {
    
    internal let disposeBag = DisposeBag()
    internal var activityData = ActivityData()
    
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(BaseViewController.handleRefresh(_:)),
                                 for: UIControl.Event.valueChanged)
        refreshControl.tintColor = UIColor.white
        
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupView()
        setupRx()
        setupMultiLanguage()
    }
    
    internal func setupView() {
        
    }
    
    internal func setupRx() {
        
    }
    
    internal func setupViewModel() {
        
    }
    
    internal func setupMultiLanguage() {
        
    }
    
    @objc
    internal func handleRefresh(_ refreshControl: UIRefreshControl) {
        
    }
    
    func showAlert(message: String,
                   title: String? = "",
                   cancel: String = "Cancel",
                   otherButtons: [String] = [],
                   action: ((String) -> Void)? = nil) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if !cancel.isEmpty {
            alertVC.addAction(UIAlertAction(title: cancel, style: .cancel, handler: nil))
        }
        otherButtons.forEach { (title) in
            alertVC.addAction(UIAlertAction(title: title, style: .default, handler: { (alertAction) in
                action?(alertAction.title ?? "")
            }))
        }
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func addLoadingIndicator(_ indicator: ActivityIndicator) {
        indicator
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] isLoading in
                self?.loadingIndicator(isLoading)
            })
            .disposed(by: disposeBag)
    }
    
    private func loadingIndicator(_ isLoading: Bool) {
        guard isLoading else {
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating(nil)
            return
        }
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData, nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        let className = String(describing: self).components(separatedBy: ".").last ?? ""
        Log.debug(message: className + "didReceiveMemoryWarning")
    }
    
    deinit {
        let className = String(describing: self).components(separatedBy: ".").last ?? ""
        Log.debug(message: className + "deinit")
    }
}
