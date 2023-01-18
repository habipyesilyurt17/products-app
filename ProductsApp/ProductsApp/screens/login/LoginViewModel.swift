//
//  LoginViewModel.swift
//  ProductsApp
//
//  Created by Habip Yeşilyurt on 18.01.2023.
//

import Foundation

final class LoginViewModel: LoginViewModelProtocol {
    var delegate: LoginViewModelDelegate?

    func login(username: String, password: String) {
        notify(.setLoading(true))
        NetworkManager.shared.login(username: username, password: password) { [weak self] result in
            guard let self = self else { return }
            self.notify(.setLoading(false))
            switch result {
            case .success(_):
                self.notify(.showHomePage(true))
            case .failure(let error):
                self.notify(.showAlert(error.localizedDescription))
            }
        }
    }
    
    private func notify(_ output: LoginViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
