//
//  UserDefaults+Extensions.swift
//  Yummie
//
//  Created by Osaretin Uyigue on 9/15/21.
//

import UIKit


extension UserDefaults {
    private enum UserDefaultKeys: String {
        case hasOnboarded
    }
    
    
    var hasOnboarded: Bool {
        get {
            bool(forKey: UserDefaultKeys.hasOnboarded.rawValue)
        }
        
        
        set {
            setValue(newValue, forKey: UserDefaultKeys.hasOnboarded.rawValue)
        }
    }
}
