//
//  CoinCollectionViewCell.swift
//  CryptocurrencyTracking
//
//  Created by Thuận Nguyễn Văn on 31/07/2021.
//

import UIKit
import Reusable
import Kingfisher
import SDWebImageSVGCoder

final class CoinCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var coinIconImage: UIImageView!
    @IBOutlet private weak var coinNameLabel: UILabel!
    @IBOutlet private weak var coinPriceLabel: UILabel!
    @IBOutlet private weak var changeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    private func configureView() {
        contentView.layer.cornerRadius = 20
        contentView.backgroundColor = .white
        changeLabel.textColor = .white
        changeLabel.layer.cornerRadius = 10
        changeLabel.layer.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    }
    
    public func configureCell(coin: CoinModel) {
        
        let iconUrl = URL(string: coin.iconUrl)
        let name = "\(coin.name) (\(coin.symbol))"

        let isIncreased = coin.change.formatChange(change: coin.change).first != "-"
        let increasedColor: CGColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        let declinedColor: CGColor = #colorLiteral(red: 0.7363152075, green: 0.1033338742, blue: 0.1612970396, alpha: 1)
        changeLabel.layer.backgroundColor = isIncreased ? increasedColor : declinedColor
        let SVGCoder = SDImageSVGCoder.shared
        SDImageCodersManager.shared.addCoder(SVGCoder)
        coinIconImage.sd_setImage(with: iconUrl)
        coinNameLabel.text = name
        coinPriceLabel.text = coin.price.formatPrice(price: coin.price)
        changeLabel.text = coin.change.formatChange(change: coin.change)
    }
}
