//
//  MockNetworkManager.swift
//  ProductsAppTests
//
//  Created by Habip Yeşilyurt on 22.01.2023.
//

@testable import ProductsApp

final class MockNetworkManager: NetworkManagerInterface {
    let products: Product = []

    func login(username: String, password: String, completion: @escaping (ResultTypeEnum<LoginResponseModel>) -> Void) {
    }
    
    var invokedFetchProducts = false
    var invokedFetchProductsCount = 0
    
    func fetchProducts(completion: @escaping (ResultTypeEnum<Product>) -> Void) {
        invokedFetchProducts = true
        invokedFetchProductsCount += 1
        
        completion(.success(products))
        completion(.failure(.fetchError))
    }
}
