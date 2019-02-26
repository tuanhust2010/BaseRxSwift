//
//  RxImagePickerControllerDelegateProxy.swift
//  BaseRxSwift
//
//  Created by nguyen.manh.tuanb on 27/02/2019.
//  Copyright © 2019 nguyen.manh.tuanb. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class RxImagePickerControllerDelegateProxy: DelegateProxy<AnyObject, Any>, DelegateProxyType,
UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    weak fileprivate(set) var imagePickerController: UIImagePickerController?
    fileprivate var _didFinishPickingSubject: PublishSubject<[String: Any]>?
    fileprivate var _didCancelPickingSubject: PublishSubject<Void>?
    var didFinishPickingSubject: Observable<[String: Any]> {
        if _didFinishPickingSubject == nil {
            _didFinishPickingSubject = PublishSubject<[String: Any]>()
        }
        return _didFinishPickingSubject!
    }
    var didCancelPickingSubject: Observable<Void> {
        if _didCancelPickingSubject == nil {
            _didCancelPickingSubject = PublishSubject<Void>()
        }
        return _didCancelPickingSubject!
    }
    
    init(parentObject: UIImagePickerController) {
        self.imagePickerController = parentObject
        super.init(parentObject: parentObject, delegateProxy: RxImagePickerControllerDelegateProxy.self)
    }
    
    static func registerKnownImplementations() {
        self.register { RxImagePickerControllerDelegateProxy(parentObject: $0) }
    }
    
    static func currentDelegate(for object: AnyObject) -> Any? {
        let imagePickerController: UIImagePickerController = castOrFatalError(object)
        return imagePickerController.delegate
    }
    
    static func setCurrentDelegate(_ delegate: Any?, to object: AnyObject) {
        let imagePickerController: UIImagePickerController = castOrFatalError(object)
        imagePickerController.delegate = castOptionalOrFatalError(delegate)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        if let subject = _didFinishPickingSubject {
            subject.onNext([:])
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func imagePickerController(_ picker: UIImagePickerController,
                                       didFinishPickingMediaWithInfo info: [String: Any]) {
        if let subject = _didFinishPickingSubject {
            subject.on(.next(info))
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    deinit {
        if let finishSubject = _didFinishPickingSubject {
            finishSubject.on(.completed)
        }
        
        if let cancelSubject = _didCancelPickingSubject {
            cancelSubject.on(.completed)
        }
    }
}

func castOrFatalError<T>(_ value: Any!) -> T {
    let maybeResult: T? = value as? T
    guard let result = maybeResult else {
        fatalError("Failure converting from \(value.debugDescription) to \(T.self)")
    }
    return result
}

func castOptionalOrFatalError<T>(_ value: Any?) -> T? {
    if value == nil {
        return nil
    }
    let v: T = castOrFatalError(value)
    return v
}
