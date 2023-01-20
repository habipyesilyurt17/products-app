//
//  HomeViewModel.swift
//  ProductsApp
//
//  Created by Habip Yeşilyurt on 19.01.2023.
//

import UIKit

protocol HomeViewModelInterface {
    var view: HomeViewInterface? { get set }
    var products: Product { get set }
    var filteredProducts: Product { get set }
    
    func viewDidLoad()
    func viewWillAppear()
    func pulledDownRefreshControl()
    func dismissKeyboard()
    func textDidChange(searchText: String)
    func numberOfItemsInSection() -> Int
    func getProduct(at indexPath: IndexPath) -> ProductResponseModel?
    func cellForItemAt(at indexPath: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell
}

final class HomeViewModel {
    weak var view: HomeViewInterface?
    internal var products: Product = []
    internal var filteredProducts: Product = []
    
    private func fetchProducts(isRefresh: Bool) {
        if !isRefresh {
            view?.startIndicator()
        }
        NetworkManager.shared.fetchProducts { [weak self] result in
            self?.view?.stopIndicator()
            switch result {
            case .success(let response):
                self?.products = response
                self?.view?.products = self?.products ?? []
                self?.view?.endRefreshing()
                self?.view?.reloadData()
            case .failure(let errorMessage):
                self?.view?.showErrorAlertMessage(errorMessage: errorMessage.rawValue)
            }
        }
    }
    
    private func searchedData(products: Product) {
        view?.products = products
        view?.reloadData()
    }
}

extension HomeViewModel: HomeViewModelInterface {
    func viewDidLoad() {
        view?.prepareSearchBar()
        view?.prepareCollectionView()
        view?.addTopGestureRecognizer()
        fetchProducts(isRefresh: false)
    }
    
    func viewWillAppear() {
        view?.prepareRefreshControl(tintColor: REFRESH_CONTROL_TINT_COLOR)
    }
    
    func pulledDownRefreshControl() {
        fetchProducts(isRefresh: true)
    }
    
    func dismissKeyboard() {
        view?.viewEndEditing()
    }
    
    func textDidChange(searchText: String) {
        if searchText == "" {
            filteredProducts = products
        } else {
            filteredProducts = products.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
        searchedData(products: filteredProducts)
    }
    
    func numberOfItemsInSection() -> Int {
        view?.products.count ?? 0
    }
    
    func getProduct(at indexPath: IndexPath) -> ProductResponseModel? {
        view?.products[indexPath.item]
    }
    
    func cellForItemAt(at indexPath: IndexPath, collectionView: UICollectionView) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCollectionViewCell,   let product = getProduct(at: indexPath) else { return UICollectionViewCell() }
        cell.configure(product: product)
        return cell
    }
}

