//
//  DetailsDataModel.swift
//  CryptocurrencyTracking
//
//  Created by Thuận Nguyễn Văn on 01/08/2021.
//

import Foundation
import ObjectMapper
import Then

struct DetailsDataModel: Then {
    var coin: CoinDetailsModel
}

extension DetailsDataModel {
    init() {
        self.init(coin: CoinDetailsModel())
    }
}

extension DetailsDataModel: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        coin <- map["coin"]
    }
}
