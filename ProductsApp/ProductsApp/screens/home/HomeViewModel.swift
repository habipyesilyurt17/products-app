//
//  HomeViewModel.swift
//  ProductsApp
//
//  Created by Habip Yeşilyurt on 19.01.2023.
//

import Foundation
final class HomeViewModel: ProductViewModelProtocol {
    var delegate: ProductViewModelDelegate?
    private var products: Product = []
    private var filteredProducts: Product = []
    
    func load(isRefresh: Bool) {
        if !isRefresh {
            notify(.setLoading(true))
        }
        NetworkManager.shared.fetchProducts { [weak self] result in
            guard let self = self else { return }
            self.notify(.setLoading(false))
            switch result {
            case .success(let response):
                self.products = response
                self.notify(.showProductList(self.products))
            case .failure(let errorMessage):
                self.notify(.showAlert(errorMessage.rawValue))
            }
        }
    }
    
    func search(searchText: String) {
        if searchText == "" {
            filteredProducts = products
        } else {
            filteredProducts = products.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
        notify(.showProductList(filteredProducts))
    }
    
    private func notify(_ output: ProductViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
    
}
