//
//  HistoryModel.swift
//  CryptocurrencyTracking
//
//  Created by Thuận Nguyễn Văn on 05/08/2021.
//

import Foundation
import ObjectMapper
import Then

struct HistoryModel: Then {
    var price: String
    var timestamp: Int64
}

extension HistoryModel {
    init() {
        self.init(
            price: "",
            timestamp: 0
        )
    }
}

extension HistoryModel: Mappable {
    
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        price <- map["price"]
        timestamp <- map ["timestamp"]
    }
}
