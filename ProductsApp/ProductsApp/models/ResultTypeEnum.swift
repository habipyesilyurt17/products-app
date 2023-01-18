//
//  ResultTypeEnum.swift
//  ProductsApp
//
//  Created by Habip Yeşilyurt on 18.01.2023.
//

import Foundation

enum ResultTypeEnum<Value> {
    case success(Value)
    case failure(ErrorTypeEnum)
}
