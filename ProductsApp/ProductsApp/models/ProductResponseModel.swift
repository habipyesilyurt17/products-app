//
//  ProductResponseModel.swift
//  ProductsApp
//
//  Created by Habip Yeşilyurt on 18.01.2023.
//

import Foundation

struct ProductResponseModel: Decodable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: Category
    let image: String
    let rating: Rating
}

enum Category: String, Decodable {
    case electronics = "electronics"
    case jewelery = "jewelery"
    case menSClothing = "men's clothing"
    case womenSClothing = "women's clothing"
}

struct Rating: Decodable {
    let rate: Double
    let count: Int
}
