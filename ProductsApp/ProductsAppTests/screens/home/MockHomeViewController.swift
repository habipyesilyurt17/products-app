//
//  MockHomeViewController.swift
//  ProductsAppTests
//
//  Created by Habip Yeşilyurt on 22.01.2023.
//

@testable import ProductsApp

final class MockHomeViewController: HomeViewInterface {
    var products: Product = []
    
    var invokedPrepareSearchBar = false
    var invokedPrepareSearchBarCount = 0
    
    func prepareSearchBar() {
        invokedPrepareSearchBar = true
        invokedPrepareSearchBarCount += 1
    }
    
    var invokedPrepareCollectionView = false
    var invokedPrepareCollectionViewCount = 0
    
    func prepareCollectionView() {
        invokedPrepareCollectionView = true
        invokedPrepareCollectionViewCount += 1
    }
    
    func prepareRefreshControl(tintColor: String) {
    }
    
    func addTopGestureRecognizer() {
    }
    
    func beginRefreshing() {
    }
    
    var invokedEndRefreshing = false
    var invokedEndRefreshingCount = 0
    
    func endRefreshing() {
        invokedEndRefreshing = true
        invokedEndRefreshingCount += 1
    }
    
    var invokedReloadData = false
    var invokedReloadDataCount = 0
    
    func reloadData() {
        invokedReloadData = true
        invokedReloadDataCount += 1
    }
    
    var invokedShowErrorAlertMessage = false
    var invokedShowErrorAlertMessageCount = 0
    
    func showErrorAlertMessage(errorMessage: String) {
        invokedShowErrorAlertMessage = true
        invokedShowErrorAlertMessageCount += 1
    }
    
    var invokedStartIndicator = false
    var invokedStartIndicatorCount = 0
    
    func startIndicator() {
        invokedStartIndicator = false
        invokedStartIndicatorCount += 1
    }
    
    var invokedStopIndicator = false
    var invokedStopIndicatorCount = 0
    
    func stopIndicator() {
        invokedStopIndicator = true
        invokedStopIndicatorCount += 1
    }
    
    func viewEndEditing() {
    }
}
