//
//  LoginViewController.swift
//  ProductsApp
//
//  Created by Habip Yeşilyurt on 18.01.2023.
//

import UIKit

protocol LoginViewInterface: AnyObject {
    var showPassword: Bool { get set }
    var isExpand: Bool { get set }
    
    func prepareEyeIconForPasswordInput()
    func prepareTextFieldDelegate()
    func showHomePage()
    func startIndicator()
    func stopIndicator()
    func showErrorAlertMessage(errorMessage: String)
    func tapGestureRecognizer()
    func viewEndEditing()
    func keyboardShow()
    func keyboardHide()
}

final class LoginViewController: BaseViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    var showPassword = true
    var isExpand = false
    var activeTextField : UITextField? = nil
    private lazy var viewModel = LoginViewModel(view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        viewModel.keyboardWillShow(notification: notification, scrollView: scrollView, viewFrameWidth: self.view.frame.width)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        viewModel.keyboardWillHide(notification: notification, scrollView: scrollView, viewFrameWidth: self.view.frame.width)
    }
    
    @objc func eyeIconTapped(topGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = topGestureRecognizer.view as! UIImageView
        viewModel.eyeIconTapped(tappedImage: tappedImage, usernameTextField: usernameTextField, passwordTextField: passwordTextField)
    }
    
    @objc private func dismissKeyboard() {
        viewModel.dismissKeyboard()
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        viewModel.loginButtonPressed(username: usernameTextField.text?.trimmingCharacters(in: .whitespaces), password: passwordTextField.text?.trimmingCharacters(in: .whitespaces))
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        self.activeTextField = nil
        if textField == usernameTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            passwordTextField.resignFirstResponder()
        }
    }
}

extension LoginViewController: LoginViewInterface {
    func prepareEyeIconForPasswordInput() {
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
    
    func prepareTextFieldDelegate() {
        usernameTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    func showHomePage() {
        let tabBarViewController = TabBarViewController()
        tabBarViewController.modalPresentationStyle = .overFullScreen
        self.present(tabBarViewController, animated: true)
    }
    
    func startIndicator() {
        indicator.startAnimating()
    }
    
    func stopIndicator() {
        indicator.stopAnimating()
    }
    
    func showErrorAlertMessage(errorMessage: String) {
        showErrorAlert(message: errorMessage)
    }
    
    func tapGestureRecognizer() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func viewEndEditing() {
        view.endEditing(true)
    }
    
    func keyboardShow() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func keyboardHide() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
