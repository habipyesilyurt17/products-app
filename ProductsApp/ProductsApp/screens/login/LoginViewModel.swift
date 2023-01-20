//
//  LoginViewModel.swift
//  ProductsApp
//
//  Created by Habip Yeşilyurt on 18.01.2023.
//

import UIKit

protocol LoginViewModelInterface {
    var view: LoginViewInterface? { get set }
    
    func viewDidLoad()
    func eyeIconTapped(tappedImage: UIImageView, usernameTextField: UITextField, passwordTextField: UITextField)
    func loginButtonPressed(username: String?, password: String?)
    func dismissKeyboard()
}

final class LoginViewModel {
    weak var view: LoginViewInterface?
    
    private func login(username: String, password: String) {
        view?.startIndicator()
        NetworkManager.shared.login(username: username, password: password) { [weak self] result in
            guard let self = self else { return }
            self.view?.stopIndicator()
            switch result {
            case .success(_):
                self.view?.showHomePage()
            case .failure(let errorMessage):
                self.view?.showErrorAlertMessage(errorMessage: errorMessage.rawValue)
            }
        }
    }
}

extension LoginViewModel: LoginViewModelInterface {
    func viewDidLoad() {
        view?.prepareEyeIconForPasswordInput()
        view?.prepareTextFieldDelegate()
        view?.tapGestureRecognizer()
    }
    
    func eyeIconTapped(tappedImage: UIImageView, usernameTextField: UITextField, passwordTextField: UITextField) {
        guard let view = view else { return }
        if view.showPassword {
            view.showPassword = false
            tappedImage.image = UIImage(systemName: "eye")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
            passwordTextField.isSecureTextEntry = false
        } else {
            view.showPassword = true
            tappedImage.image = UIImage(systemName: "eye.slash")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
            passwordTextField.isSecureTextEntry = true
        }

    }
    
    func loginButtonPressed(username: String?, password: String?) {
        guard let username =  username else { return }
        guard let password =  password else { return }
        login(username: username, password: password)
    }
    
    func dismissKeyboard() {
        view?.viewEndEditing()
    }
}
