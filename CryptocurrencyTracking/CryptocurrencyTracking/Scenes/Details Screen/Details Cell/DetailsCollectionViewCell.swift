//
//  DetailsCollectionViewCell.swift
//  CryptocurrencyTracking
//
//  Created by Thuận Nguyễn Văn on 05/08/2021.
//

import UIKit
import Reusable

final class DetailsCollectionViewCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var priceToBTCLabel: UILabel!
    @IBOutlet private weak var rankLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    private func configureView() {
        
    }
    
    public func configureCell(details: CoinDetailsModel) {
        priceLabel.text = details.price.formatPrice(price: details.price)
        let btcPrice = details.btcPrice.formatChange(change: details.btcPrice)
        priceToBTCLabel.text = "\(btcPrice) BTC"
        rankLabel.text = "\(details.rank)"
    }
}
