//
//  Dish.swift
//  Yummie
//
//  Created by Osaretin Uyigue on 7/21/21.
//

//
//  Struct
//
//  Created by Osaretin Uyigue on 4/29/19.
//  Copyright © 2019 Osaretin Uyigue. All rights reserved.
//

import UIKit
struct Dish: Codable {
    
    let id, name, description, image: String?
    let calories: Int?

    var formattedCalories: String {
        return String(format: "\(calories ?? 0) calories")
    }
    
        
    
}
