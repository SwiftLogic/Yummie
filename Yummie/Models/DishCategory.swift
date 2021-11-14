//
//  DishCategory.swift
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
struct DishCategory: Codable {
    let id, name, image: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
        case image
    }
    
    //MARK: - Code Was Created by SamiSays11. Copyright © 2019 SamiSays11 All rights reserved.
    
    
}
