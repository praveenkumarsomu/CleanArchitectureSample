//
//  UserDefaults+PropertyWrapper.swift
//  List
//
//  Created by Praveenkumar Somu on 27/3/2563 BE.
//  Copyright © 2563 Praveenkumar Somu. All rights reserved.
//

import Foundation

@propertyWrapper
struct UserDefaultsRepo {
    let key: String
    var storage: UserDefaults = .standard
    
    var wrappedValue: String? {
        get { storage.value(forKey: key) as? String }
        set { storage.setValue(newValue, forKey: key) }
    }
}
