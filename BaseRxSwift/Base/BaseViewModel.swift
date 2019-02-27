//
//  BaseViewModel.swift
//  BaseRxSwift
//
//  Created by nguyen.manh.tuanb on 27/02/2019.
//  Copyright © 2019 nguyen.manh.tuanb. All rights reserved.
//

import Foundation
import RxSwift

open class BaseViewModel {
    public let activityIndicator = ActivityIndicator()
    open var disposeBag = DisposeBag()
    
    public init() {}
}

