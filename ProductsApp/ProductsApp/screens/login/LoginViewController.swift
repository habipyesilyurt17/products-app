//
//  LoginViewController.swift
//  ProductsApp
//
//  Created by Habip Yeşilyurt on 18.01.2023.
//

import UIKit

final class LoginViewController: BaseViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var showPassword = true
    var viewModel: LoginViewModelProtocol = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePasswordInput()
        usernameTextField.delegate = self
        passwordTextField.delegate = self
//        usernameTextField.text = "mor_2314"
//        passwordTextField.text = "83r5^_"
        viewModel.delegate = self
    }
    
    private func configurePasswordInput() {
        let eyeIcon = UIImageView()
        let contentView = UIView()
        
        eyeIcon.image = UIImage(systemName: "eye.slash")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
        
        contentView.addSubview(eyeIcon)
        
        contentView.frame = CGRect(x: 0, y: 0, width: UIImage(systemName: "eye.slash")!.size.width, height: UIImage(systemName: "eye.slash")!.size.height)
        eyeIcon.frame = CGRect(x: -10, y: 0, width: UIImage(systemName: "eye.slash")!.size.width, height: UIImage(systemName: "eye.slash")!.size.height)
        passwordTextField.rightView = contentView
        passwordTextField.rightViewMode = .always
        
        let topGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(eyeIconTapped(topGestureRecognizer:)))
        eyeIcon.isUserInteractionEnabled = true
        eyeIcon.addGestureRecognizer(topGestureRecognizer)
    }
    
    @objc func eyeIconTapped(topGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = topGestureRecognizer.view as! UIImageView
        if showPassword {
            showPassword = false
            tappedImage.image = UIImage(systemName: "eye")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
            passwordTextField.isSecureTextEntry = false
        } else {
            showPassword = true
            tappedImage.image = UIImage(systemName: "eye.slash")?.withTintColor(.systemGray, renderingMode: .alwaysOriginal)
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        guard let username = usernameTextField.text?.trimmingCharacters(in: .whitespaces) else { return }
        guard let password = passwordTextField.text?.trimmingCharacters(in: .whitespaces) else { return }
        viewModel.login(username: username, password: password)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension LoginViewController: LoginViewModelDelegate {
    func handleViewModelOutput(_ output: LoginViewModelOutput) {
        switch output {
        case .setLoading(let isLoading):
            isLoading ? indicator.startAnimating() : indicator.stopAnimating()
        case .showAlert(let errorMessage):
            self.showErrorAlert(message: errorMessage)
            self.indicator.stopAnimating()
        case .showHomePage(_):
            let tabBarViewController = TabBarViewController()
            tabBarViewController.modalPresentationStyle = .overFullScreen
            self.present(tabBarViewController, animated: true)
        }
    }
}
