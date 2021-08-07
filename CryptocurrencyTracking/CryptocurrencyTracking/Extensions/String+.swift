//
//  String+.swift
//  CryptocurrencyTracking
//
//  Created by Thuận Nguyễn Văn on 01/08/2021.
//

import Foundation

extension String {
    public func formatPrice(price: String) -> String {
        guard let priceFloat = Float(price) else { return "" }
        let priceFormatted = Float(Int(priceFloat * 100)) / 100.00
        return "$\(priceFormatted)"
    }
    
    public func formatChange(change: String) -> String {
        guard let changeFloat = Float(change) else { return "" }
        let changeFormatted = Float(Int(changeFloat * 100)) / 100.00
        return "\(changeFormatted)"
    }
}
