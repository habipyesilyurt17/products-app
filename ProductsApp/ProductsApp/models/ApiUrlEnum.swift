//
//  ApiUrlEnum.swift
//  ProductsApp
//
//  Created by Habip Yeşilyurt on 18.01.2023.
//

import Foundation

enum ApiUrlEnum {
    static func login() -> String {
        BASE_URL + LOGIN_URL
    }
    
    static func fetchProducts() -> String {
        BASE_URL + PRODUCT_URL
    }
}
