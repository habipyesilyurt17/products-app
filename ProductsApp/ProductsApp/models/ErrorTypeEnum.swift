//
//  ErrorTypeEnum.swift
//  ProductsApp
//
//  Created by Habip Yeşilyurt on 18.01.2023.
//

import Foundation

enum ErrorTypeEnum: String, Error {
    case invalidData  = "Invalid data"
    case fetchError   = "Data couldn't be fetched"
    case networkError = "Check network"
}
