//
//  TabBarViewController.swift
//  ProductsApp
//
//  Created by Habip Yeşilyurt on 19.01.2023.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        let homeController     = HomeViewController()
        let savedController    = SavedViewController()
        let cartController     = CartViewController()
        let settingsController = SettingsViewController()
        
        homeController.title = "Home"
        savedController.title = "Saved"
        cartController.title = "Cart"
        settingsController.title = "Settings"
        
        self.setViewControllers([homeController, savedController, cartController, settingsController], animated: true)
        
        guard let items = self.tabBar.items else { return }
        let itemImages = ["house", "heart", "cart", "gearshape"]
        
        for i in 0...itemImages.count - 1 {
            items[i].image = UIImage(systemName: itemImages[i])
        }
        
        self.tabBar.layer.borderWidth = 0.2
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = UIColor(red: CGFloat(104/255.0), green: CGFloat(189/255.0), blue: CGFloat(73/255.0), alpha: CGFloat(1.0))
    }
}
