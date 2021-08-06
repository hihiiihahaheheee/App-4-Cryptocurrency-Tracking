//
//  TimePeriodCollectionViewCell.swift
//  CryptocurrencyTracking
//
//  Created by Thuận Nguyễn Văn on 06/08/2021.
//

import UIKit
import Reusable

final class TimePeriodCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }
    
    private func configureView() {
        contentView.layer.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        contentView.layer.cornerRadius = 15
        timeLabel.textColor = .darkGray
    }
    
    public func configureCell(text: String) {
        timeLabel.text = text
    }
}
