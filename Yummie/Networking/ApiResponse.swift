//
//  ApiResponse.swift
//  Yummie
//
//  Created by Osaretin Uyigue on 9/11/21.
//

import UIKit
struct ApiResponse<T: Decodable>: Decodable {
    let status: Int
    let message: String?
    let data: T?
    let error: String?    
}
