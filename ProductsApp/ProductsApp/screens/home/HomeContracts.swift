//
//  HomeContracts.swift
//  ProductsApp
//
//  Created by Habip Yeşilyurt on 19.01.2023.
//

import Foundation

protocol ProductViewModelProtocol {
    var delegate: ProductViewModelDelegate? { get set }
    func load()
    func search(searchText: String)
}

enum ProductViewModelOutput: Equatable {
    static func == (lhs: ProductViewModelOutput, rhs: ProductViewModelOutput) -> Bool {
        return true
    }
    case setLoading(Bool)
    case showAlert(String)
    case showProductList([ProductResponseModel])
}

protocol ProductViewModelDelegate {
    func handleViewModelOutput(_ output: ProductViewModelOutput)
}
