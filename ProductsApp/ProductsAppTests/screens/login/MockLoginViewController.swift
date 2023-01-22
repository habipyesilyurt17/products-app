//
//  MockLoginViewController.swift
//  ProductsAppTests
//
//  Created by Habip Yeşilyurt on 22.01.2023.
//

@testable import ProductsApp

final class MockLoginViewController: LoginViewInterface {
    var showPassword: Bool = false
    var isExpand: Bool = false
    
    var invokedPrepareEyeIconForPasswordInput = false
    var invokedPrepareEyeIconForPasswordInputCount = 0
    
    func prepareEyeIconForPasswordInput() {
        invokedPrepareEyeIconForPasswordInput = true
        invokedPrepareEyeIconForPasswordInputCount += 1
    }
    
    var invokedPrepareTextFieldDelegate = false
    var invokedPrepareTextFieldDelegateCount = 0
    
    func prepareTextFieldDelegate() {
        invokedPrepareTextFieldDelegate = true
        invokedPrepareTextFieldDelegateCount += 1
    }
    
    func showHomePage() {
    }
    
    func startIndicator() {
    }
    
    func stopIndicator() {
    }
    
    func showErrorAlertMessage(errorMessage: String) {
    }
    
    var invokedTapGestureRecognizer = false
    var invokedTapGestureRecognizerCount = 0
    
    func tapGestureRecognizer() {
        invokedTapGestureRecognizer = true
        invokedTapGestureRecognizerCount += 1
    }
    
    func viewEndEditing() {
    }
    
    var invokedKeyboardShow = false
    var invokedKeyboardShowCount = 0
    
    func keyboardShow() {
        invokedKeyboardShow = true
        invokedKeyboardShowCount += 1
    }
    
    var invokedKeyboardHide = false
    var invokedKeyboardHideCount = 0
    
    func keyboardHide() {
        invokedKeyboardHide = true
        invokedKeyboardHideCount += 1
    }
}
