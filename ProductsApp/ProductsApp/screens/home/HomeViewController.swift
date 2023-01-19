//
//  HomeViewController.swift
//  ProductsApp
//
//  Created by Habip Yeşilyurt on 19.01.2023.
//

import UIKit

final class HomeViewController: BaseViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    private var products: Product = []
    
    var viewModel: ProductViewModelProtocol = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        configureCollectionView()
        viewModel.delegate = self
        viewModel.load()
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
        searchBar.barTintColor = .white
        searchBar.setBackgroundImage(UIImage.init(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.size.width/3, height: 270)
        collectionView.collectionViewLayout = layout
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(searchText: searchText)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell() }
        cell.configure(product: products[indexPath.row])
        return cell
    }
}

extension HomeViewController: ProductViewModelDelegate {
    func handleViewModelOutput(_ output: ProductViewModelOutput) {
        switch output {
        case .setLoading(let isLoading):
            isLoading ? indicator.startAnimating() : indicator.startAnimating()
        case .showAlert(let errorMessage):
            showErrorAlert(message: errorMessage) { [weak self] in
                guard let self = self else { return }
                self.indicator.stopAnimating()
            }
        case .showProductList(let products):
            self.products = products
            collectionView.reloadData()
        }
    }
}
