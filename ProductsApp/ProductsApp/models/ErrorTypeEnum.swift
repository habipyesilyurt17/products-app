//
//  ErrorTypeEnum.swift
//  ProductsApp
//
//  Created by Habip Yeşilyurt on 18.01.2023.
//

import Foundation

enum ErrorTypeEnum: String, Error {
    case loginError    = "Username or password is incorrect"
    case fetchError    = "Data couldn't be fetched"
    case internetError = "Check internet"
    case userLoginInfoError = "Username and password cant be empty"
}
