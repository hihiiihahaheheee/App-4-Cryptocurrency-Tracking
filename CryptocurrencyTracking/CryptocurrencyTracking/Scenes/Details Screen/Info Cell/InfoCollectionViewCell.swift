//
//  InfoCollectionViewCell.swift
//  CryptocurrencyTracking
//
//  Created by Thuận Nguyễn Văn on 05/08/2021.
//

import UIKit
import Reusable
import SDWebImageSVGCoder

final class InfoCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var coinNameLabel: UILabel!
    @IBOutlet private weak var priceLabel: UILabel!
    @IBOutlet private weak var changeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    private func configureView() {
        contentView.backgroundColor = .white
        changeLabel.textColor = .white
        changeLabel.layer.cornerRadius = 10
        changeLabel.layer.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
    }
    
    public func configureCell(coinDetails: CoinDetailsModel) {
        let iconUrl = URL(string: coinDetails.iconUrl)
        let name = "\(coinDetails.name) (\(coinDetails.symbol))"

        let isIncreased = coinDetails.change.formatChange(change: coinDetails.change).first != "-"
        let increasedColor: CGColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        let declinedColor: CGColor = #colorLiteral(red: 0.7363152075, green: 0.1033338742, blue: 0.1612970396, alpha: 1)
        changeLabel.layer.backgroundColor = isIncreased ? increasedColor : declinedColor
        let SVGCoder = SDImageSVGCoder.shared
        SDImageCodersManager.shared.addCoder(SVGCoder)
        imageView.sd_setImage(with: iconUrl)
        coinNameLabel.text = name
        priceLabel.text = coinDetails.price.formatPrice(price: coinDetails.price)
        changeLabel.text = coinDetails.change.formatChange(change: coinDetails.change)
    }
}
