//
//  HomeViewModelTests.swift
//  ProductsAppTests
//
//  Created by Habip Yeşilyurt on 22.01.2023.
//

import XCTest
import Alamofire
@testable import ProductsApp

final class HomeViewModelTests: XCTestCase {
    private var viewModel: HomeViewModel!
    private var view: MockHomeViewController!
    private var networkManager: MockNetworkManager!
    
    override func setUp() {
        super.setUp()
        view = .init()
        networkManager = .init()
        viewModel = .init(view: view, networkManager: networkManager)
    }
    
    override func tearDown() {
        super.tearDown()
        view = nil
        networkManager = nil
        viewModel = nil
    }
    
    func test_viewDidLoad_InvokesRequiredMethods() {
        XCTAssertFalse(view.invokedPrepareSearchBar)
        XCTAssertFalse(view.invokedPrepareCollectionView)
        XCTAssertFalse(networkManager.invokedFetchProducts)
        XCTAssertFalse(view.invokedStopIndicator)
        XCTAssertFalse(view.invokedStopIndicator)
        XCTAssertFalse(view.invokedEndRefreshing)
        XCTAssertFalse(view.invokedReloadData)
        XCTAssertFalse(view.invokedShowErrorAlertMessage)
        
        viewModel.viewDidLoad()
        
        XCTAssertEqual(view.invokedPrepareSearchBarCount, 1)
        XCTAssertEqual(view.invokedPrepareCollectionViewCount, 1)
        XCTAssertEqual(networkManager.invokedFetchProductsCount, 1)
        XCTAssertEqual(view.invokedStartIndicatorCount, 1)
        XCTAssertEqual(view.invokedStopIndicatorCount, 2)
        XCTAssertEqual(view.invokedEndRefreshingCount, 1)
        XCTAssertEqual(view.invokedReloadDataCount, 1)
        XCTAssertEqual(view.invokedShowErrorAlertMessageCount, 1)
    }
    
    
    func test_GetProducts_SuccessReturnsProductsAndProductsCount() {
        let urlString = ApiUrlEnum.fetchProducts()
        let productsExpectation = expectation(description: "products")
        var productsResponse: Product?
        
        AF.request(urlString).responseDecodable(of: Product.self) { response in
            switch response.result {
            case .success(let data):
                productsResponse = data
                productsExpectation.fulfill()
            case .failure(_):
                XCTAssertNil(response.error)
            }
        }
        
        waitForExpectations(timeout: 2.0) { (error) in
            XCTAssertNotNil(productsResponse)
            XCTAssertEqual(productsResponse?.count, 20)
        }
    }
}
