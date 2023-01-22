//
//  String+Ext.swift
//  ProductsApp
//
//  Created by Habip Yeşilyurt on 23.01.2023.
//

import Foundation

extension String {
    func localized() -> String {
        NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
