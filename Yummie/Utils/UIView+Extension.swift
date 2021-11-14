//
//  UIView+Extension.swift
//  Yummie
//
//  Created by Osaretin Uyigue on 7/16/21.
//

import UIKit
extension UIView {
    
    var cornerRadius: CGFloat {
        get {return cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    
}



