//
//  TabBarViewController.swift
//  ProductsApp
//
//  Created by Habip Yeşilyurt on 19.01.2023.
//

import UIKit

protocol TabBarViewInterface: AnyObject {
    func prepareTabBarItemsController()
    func prepareTabBar()
}

final class TabBarViewController: UITabBarController {
    private lazy var viewModel = TabBarViewModel()
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.view = self
        viewModel.viewWillAppear()
        viewModel.setTabBarItemsImage(items: self.tabBar.items)
    }
}

extension TabBarViewController: TabBarViewInterface {
    func prepareTabBarItemsController() {
        let homeController     = HomeViewController()
        let savedController    = SavedViewController()
        let cartController     = CartViewController()
        let settingsController = SettingsViewController()
        
        homeController.title = "Home"
        savedController.title = "Saved"
        cartController.title = "Cart"
        settingsController.title = "Settings"
        
        self.setViewControllers([homeController, savedController, cartController, settingsController], animated: true)
    }
    
    func prepareTabBar() {
        self.tabBar.layer.borderWidth = 0.2
        self.tabBar.backgroundColor = .white
        self.tabBar.tintColor = .init(hexString: TABBAR_TINT_COLOR)
    }
}
