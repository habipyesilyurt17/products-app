//
//  TabBarViewModel.swift
//  ProductsApp
//
//  Created by Habip Yeşilyurt on 21.01.2023.
//

import UIKit

protocol TabBarViewModelInterface {
    var view: TabBarViewInterface? { get set }
    
    func viewWillAppear()
    func setTabBarItemsImage(items: [UITabBarItem]?)
}

final class TabBarViewModel {
    weak var view: TabBarViewInterface?
}

extension TabBarViewModel: TabBarViewModelInterface {
    func viewWillAppear() {
        view?.prepareTabBarItemsController()
        view?.prepareTabBar()
    }
    
    func setTabBarItemsImage(items: [UITabBarItem]?) {
        guard let items = items else { return }
        let itemImages = ["house", "heart", "cart", "gearshape"]
        
        for i in 0...itemImages.count - 1 {
            items[i].image = UIImage(systemName: itemImages[i])
        }
    }
}
