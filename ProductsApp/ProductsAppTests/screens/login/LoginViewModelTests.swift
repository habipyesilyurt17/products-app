//
//  LoginViewModelTests.swift
//  ProductsAppTests
//
//  Created by Habip Yeşilyurt on 22.01.2023.
//

import XCTest
import Alamofire
@testable import ProductsApp

final class LoginViewModelTests: XCTestCase {
    private var viewModel: LoginViewModel!
    private var view: MockLoginViewController!
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
        XCTAssertFalse(view.invokedPrepareEyeIconForPasswordInput)
        XCTAssertFalse(view.invokedPrepareTextFieldDelegate)
        XCTAssertFalse(view.invokedTapGestureRecognizer)
        XCTAssertFalse(view.invokedKeyboardShow)
        XCTAssertFalse(view.invokedKeyboardHide)
        
        viewModel.viewDidLoad()
        
        XCTAssertEqual(view.invokedPrepareEyeIconForPasswordInputCount, 1)
        XCTAssertEqual(view.invokedPrepareTextFieldDelegateCount, 1)
        XCTAssertEqual(view.invokedTapGestureRecognizerCount, 1)
        XCTAssertEqual(view.invokedKeyboardShowCount, 1)
        XCTAssertEqual(view.invokedKeyboardHideCount, 1)
    }
    
    func test_Login_Success() {
        let urlString = ApiUrlEnum.login()
        let loginExpectation = expectation(description: "login")
        var loginResponse: LoginResponseModel?
        let params: Parameters = [
            "username": "mor_2314",
            "password": "83r5^_"
        ]
        
        AF.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(LoginResponseModel.self, from: data)
                    loginResponse = response
                    loginExpectation.fulfill()
                } catch {
                    XCTAssertNil(response.error)
                }
                
            case .failure(_):
                XCTAssertNil(response.error)
            }
        }
        
        waitForExpectations(timeout: 5.0) { (error) in
            XCTAssertNotNil(loginResponse)
        }
    }
    
    func test_Login_Fail() {
        let urlString = ApiUrlEnum.login()
        let loginExpectation = expectation(description: "login")
        let params: Parameters = [
            "username": "mor_2314",
            "password": "83r5^_**"
        ]
        
        AF.request(urlString, method: .post, parameters: params, encoding: JSONEncoding.default).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let _ = try JSONDecoder().decode(LoginResponseModel.self, from: data)
                    loginExpectation.fulfill()
                } catch {
                    XCTAssertNil(response.error)
                }
                
            case .failure(_):
                XCTAssertNil(response.error)
            }
        }
        
        waitForExpectations(timeout: 5.0) { (error) in
            XCTAssertNil(error)
        }
    }
}
