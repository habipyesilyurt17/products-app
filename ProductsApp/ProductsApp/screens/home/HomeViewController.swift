//
//  HomeViewController.swift
//  ProductsApp
//
//  Created by Habip Yeşilyurt on 19.01.2023.
//

import UIKit

protocol HomeViewInterface: AnyObject {
    var products: Product { get set }
    
    func prepareSearchBar()
    func prepareCollectionView()
    func prepareRefreshControl(tintColor: String)
    func addTopGestureRecognizer()
    func beginRefreshing()
    func endRefreshing()
    func reloadData()
    func showErrorAlertMessage(errorMessage: String)
    func startIndicator()
    func stopIndicator()
    func viewEndEditing()
}

final class HomeViewController: BaseViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    private lazy var viewModel = HomeViewModel(view: self)
    internal var products: Product = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.viewWillAppear()
    }
    
    @objc private func pulledDownRefreshControl() {
        viewModel.pulledDownRefreshControl()
    }
    
    @objc private func dismissKeyboard() {
        viewModel.dismissKeyboard()
    }
}

extension HomeViewController: HomeViewInterface {
    func prepareSearchBar() {
        searchBar.delegate = self
        searchBar.barTintColor = .white
        searchBar.setBackgroundImage(UIImage.init(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
    }
    
    func prepareCollectionView() {
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.size.width/3, height: 270)
        collectionView.collectionViewLayout = layout
        collectionView.reloadData()
    }
    
    func prepareRefreshControl(tintColor: String) {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .init(hexString: tintColor)
        refreshControl.addTarget(self, action: #selector(pulledDownRefreshControl), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    
    func addTopGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func beginRefreshing() {
        collectionView.refreshControl?.beginRefreshing()
    }
    
    func endRefreshing() {
        collectionView.refreshControl?.endRefreshing()
    }
    
    func reloadData() {
        collectionView.reloadData()
    }
    
    func showErrorAlertMessage(errorMessage: String) {
        showErrorAlert(message: errorMessage)
    }
    
    func startIndicator() {
        indicator.startAnimating()
    }
    
    func stopIndicator() {
        indicator.stopAnimating()
    }
    
    func viewEndEditing() {
        view.endEditing(true)
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.textDidChange(searchText: searchText)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        viewModel.cellForItemAt(at: indexPath, collectionView: collectionView)
    }
}
