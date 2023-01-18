//
//  LoginViewController.swift
//  ProductsApp
//
//  Created by Habip Yeşilyurt on 18.01.2023.
//

import UIKit

final class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var showPassword = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePasswordInput()
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
    }
    
}
