//
//  BaseViewModel.swift
//  BaseRxSwift
//
//  Created by nguyen.manh.tuanb on 27/02/2019.
//  Copyright © 2019 nguyen.manh.tuanb. All rights reserved.
//

import Foundation
import RxSwift

public class BaseViewModel {
    let activityIndicator = ActivityIndicator()
    internal var disposeBag = DisposeBag()
}

