//
//  AppError.swift
//  Yummie
//
//  Created by Osaretin Uyigue on 9/11/21.
//

import Foundation
enum AppError: LocalizedError {
    case errorDecoding
    case unknownError
    case invalidUrl
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
        
        case .errorDecoding:
            return "Response could not be decoded"
        case .unknownError:
            return "Bruh!!! I have no idea what's going on"
        case .invalidUrl:
            return  "HEY!!! Give me a valid URL"
        case .serverError(let error):
            return error
        }
    }
}
