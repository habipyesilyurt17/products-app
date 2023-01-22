//
//  BaseViewController.swift
//  ProductsApp
//
//  Created by Habip Yeşilyurt on 18.01.2023.
//

import UIKit
import MaterialActivityIndicator
import SwiftAlertView

class BaseViewController: UIViewController {
    let indicator = MaterialActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureActivityIndicatorView()
    }
    
    private func configureActivityIndicatorView() {
        view.addSubview(indicator)
        configureActivityIndicatorViewConstraints()
    }

    private func configureActivityIndicatorViewConstraints() {
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    func showErrorAlert(message: String) {
        SwiftAlertView.show(title: "Error".localized(), message: message.localized(), buttonTitles: ["Ok".localized()])
    }
}
