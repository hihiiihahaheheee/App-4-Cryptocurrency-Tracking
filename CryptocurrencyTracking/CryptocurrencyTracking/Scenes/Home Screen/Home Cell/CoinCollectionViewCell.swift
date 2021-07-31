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
    
    private func formatPrice(price: String) -> String {
        guard let priceFloat = Float(price) else { return "" }
        let priceFormatted = Float(Int(priceFloat * 100)) / 100.00
        return "$\(priceFormatted)"
    }
    
    private func formatChange(change: String) -> String {
        guard let changeFloat = Float(change) else { return "" }
        let changeFormatted = Float(Int(changeFloat * 100)) / 100.00
        return "\(changeFormatted)%"
    }
    
    public func configureCell(coin: CoinModel) {
        
        let iconUrl = URL(string: coin.iconUrl)
        let name = "\(coin.name) (\(coin.symbol))"

        let isIncreased = formatChange(change: coin.change).first != "-"
        let increasedColor: CGColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        let declinedColor: CGColor = #colorLiteral(red: 0.7363152075, green: 0.1033338742, blue: 0.1612970396, alpha: 1)
        changeLabel.layer.backgroundColor = isIncreased ? increasedColor : declinedColor
        let SVGCoder = SDImageSVGCoder.shared
        SDImageCodersManager.shared.addCoder(SVGCoder)
        coinIconImage.sd_setImage(with: iconUrl)
        coinNameLabel.text = name
        coinPriceLabel.text = formatPrice(price: coin.price)
        changeLabel.text = formatChange(change: coin.change)
    }
}
