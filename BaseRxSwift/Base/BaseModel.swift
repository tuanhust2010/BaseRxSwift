//
//  BaseModel.swift
//  BaseRxSwift
//
//  Created by nguyen.manh.tuanb on 27/02/2019.
//  Copyright © 2019 nguyen.manh.tuanb. All rights reserved.
//

import Foundation

open class BaseModel: NSObject {
    
    private var ignoresParams: [String] = []
    
    private func listPropertiesWithValues() -> [String: Any] {
        var params: [String: Any] = [:]
        let mirror = Mirror(reflecting: self)
        for attr in mirror.children {
            if let propertyName = attr.label {
                if ignoresParams.contains(propertyName) {
                    params[propertyName] = attr.value
                } else if let value = attr.value as? String, !value.isEmpty {
                    params[propertyName] = value
                } else if let value = attr.value as? [Any], (!value.isEmpty) {
                    params[propertyName] = value
                } else if let value = attr.value as? Bool {
                    params[propertyName] = value
                } else if let value = attr.value as? Float {
                    params[propertyName] = value
                } else if let value = attr.value as? Int, value > 0 {
                    params[propertyName] = value
                } else if let value = attr.value as? Double {
                    params[propertyName] = value
                } else if let value = attr.value as? BaseModel {
                    params[propertyName] = value.exportParams()
                }
            }
        }
        return params
    }
    
    open func setIgnores(params: [String]) {
        ignoresParams = params
    }
    
    open func exportParams() -> [String: Any] {
        return listPropertiesWithValues()
    }
    
}

extension BaseModel {
    
    open func validate() -> Bool {
        let mirror = Mirror(reflecting: self)
        for attr in mirror.children {
            if let propertyName = attr.label {
                if ignoresParams.contains(propertyName) { return true }
                
                if let value = attr.value as? String, value.isEmpty {
                    return false
                } else if let value = attr.value as? [Any], value.isEmpty {
                    return false
                } else if let value = attr.value as? Float, value == 0 {
                    return false
                } else if let value = attr.value as? Int, value <= 0 {
                    return false
                }
            }
        }
        return true
    }
}
