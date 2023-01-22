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

extension UISearchBar {
    @IBInspectable
    var keyPlaceholder: String {
        set{
            self.placeholder = newValue.localized()
        }
        get{
            return placeholder ?? ""
        }
    }
}
