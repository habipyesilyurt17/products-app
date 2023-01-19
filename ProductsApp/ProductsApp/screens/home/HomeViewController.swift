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
    private lazy var refreshControl = UIRefreshControl()
    
    var viewModel: ProductViewModelProtocol = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        configureCollectionView()
        configureRefreshControl()
        viewModel.delegate = self
        viewModel.load(isRefresh: false)
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
        collectionView.refreshControl = refreshControl
        collectionView.addSubview(refreshControl)
    }
    
    private func configureRefreshControl() {
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching Product Data ...")
        refreshControl.addTarget(self, action: #selector(refreshProductData(_:)), for: .valueChanged)
    }

    @objc private func refreshProductData(_ sender: AnyObject) {
        viewModel.load(isRefresh: true)
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
            isLoading ? indicator.startAnimating() : indicator.stopAnimating()
        case .showAlert(let errorMessage):
            showErrorAlert(message: errorMessage) { [weak self] in
                guard let self = self else { return }
                self.refreshControl.endRefreshing()
            }
        case .showProductList(let products):
            self.products = products
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
}
