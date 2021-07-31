//
//  CoinModel.swift
//  CryptocurrencyTracking
//
//  Created by Thuận Nguyễn Văn on 31/07/2021.
//

import Foundation
import ObjectMapper
import Then

struct CoinModel: Then {
    
    var uuid: String
    var symbol: String
    var name: String
    var iconUrl: String
    var marketCap: String
    var price: String
    var listedAt: Int
    var tier: Int
    var change: String
    var rank: Int
    var coinrankingUrl: String
    var twentyFourHourVolume: String
    var btcPrice: String
}

extension CoinModel {
    
    init() {
        self.init(
            uuid: "",
            symbol: "",
            name: "",
            iconUrl: "",
            marketCap: "",
            price: "",
            listedAt: 0,
            tier: 0,
            change: "",
            rank: 0,
            coinrankingUrl: "",
            twentyFourHourVolume: "",
            btcPrice: ""
        )
    }
}

extension CoinModel: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        uuid <- map["uuid"]
        symbol <- map["symbol"]
        iconUrl <- map["iconUrl"]
        marketCap <- map["marketCap"]
        price <- map["price"]
        listedAt <- map["listedAt"]
        tier <- map["tier"]
        change <- map["change"]
        rank <- map["rank"]
        coinrankingUrl <- map["coinrankingUrl"]
        twentyFourHourVolume <- map["24hVolume"]
        btcPrice <- map["btcPrice"]
    }
}
