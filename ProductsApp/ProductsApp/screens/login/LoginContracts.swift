//
//  LoginContracts.swift
//  ProductsApp
//
//  Created by Habip Yeşilyurt on 18.01.2023.
//

import Foundation

protocol LoginViewModelProtocol {
    var delegate: LoginViewModelDelegate? { get set }
    func login(username: String, password: String)
}

enum LoginViewModelOutput: Equatable {
    case setLoading(Bool)
    case showAlert(String)
    case showHomePage(Bool)
}

protocol LoginViewModelDelegate {
    func handleViewModelOutput(_ output: LoginViewModelOutput)
}
