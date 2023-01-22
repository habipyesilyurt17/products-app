//
//  UIComponents+Localizable+Ext.swift
//  ProductsApp
//
//  Created by Habip Yeşilyurt on 23.01.2023.
//

import UIKit

protocol XIBLocalizableInterface {
    var xibLocKey: String? { get set }
}

extension UILabel: XIBLocalizableInterface {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            text = key?.localized()
        }
    }
}

extension UIButton: XIBLocalizableInterface {
    @IBInspectable var xibLocKey: String? {
        get { return nil }
        set(key) {
            setTitle(key?.localized(), for: .normal)
        }
    }
}

protocol XIBLocalizableForPlaceholderInterface {
    var keyPlaceholder: String? { get set }
}

extension UISearchBar: XIBLocalizableForPlaceholderInterface {
    @IBInspectable var keyPlaceholder: String? {
        get { return nil }
        set(key) {
            placeholder = key?.localized()
        }
    }
}

extension UITextField: XIBLocalizableForPlaceholderInterface {
    @IBInspectable var keyPlaceholder: String? {
        get { return nil }
        set(key) {
            placeholder = key?.localized()
        }
    }
}
