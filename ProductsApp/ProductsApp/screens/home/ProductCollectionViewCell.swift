//
//  ProductCollectionViewCell.swift
//  ProductsApp
//
//  Created by Habip Yeşilyurt on 19.01.2023.
//

import UIKit
import Cosmos
import AlamofireImage

final class ProductCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    func configure(product: ProductResponseModel) {
        cosmosView.settings.fillMode = .precise
        cosmosView.rating = product.rating.rate
        cosmosView.settings.totalStars = 5
        cosmosView.settings.updateOnTouch = false
        productTitle.text = product.title
        productPrice.text = "\(product.price)"
        guard let url = URL(string: product.image) else { return }
        productImage.af.setImage(withURL: url)
    }
}
