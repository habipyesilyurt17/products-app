//
//  CacheManager.swift
//  ProductsApp
//
//  Created by Habip Yeşilyurt on 19.01.2023.
//

import Foundation

protocol CacheManagerProtocol {
    func getProducts(completion: @escaping (Product?) -> ())
    func setProducst(products: Product)
}

struct CacheManager: CacheManagerProtocol {
    static let shared = CacheManager()
    private let cache = NSCache<NSString, NSArray>()
    
    func getProducts(completion: @escaping (Product?) -> ()) {
        if let cachedData = cache.object(forKey: "products") as? Product {
            completion(cachedData)
            return
        }
        completion(nil)
    }
    
    func setProducst(products: Product) {
        self.cache.setObject(products as NSArray, forKey: "products")
    }
}

