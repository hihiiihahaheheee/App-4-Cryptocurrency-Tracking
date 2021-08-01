//
//  CoinDetailsModel.swift
//  CryptocurrencyTracking
//
//  Created by Thuận Nguyễn Văn on 31/07/2021.
//

import Foundation
import ObjectMapper
import Then

struct CoinDetailsModel: Then {
    var uuid: String
    var symbol: String
    var name: String
    var description: String
    var iconUrl: String
    var websiteUrl: String
    var price: String
    var twentyFourHourVolume: String
    var marketCap: String
    var btcPrice: String
    var change: String
    var rank: Int
    var coinrankingUrl: String
    var sparkline: [String]
}

extension CoinDetailsModel {
    init() {
        self.init(
            uuid: "",
            symbol: "",
            name: "",
            description: "",
            iconUrl: "",
            websiteUrl: "",
            price: "",
            twentyFourHourVolume: "",
            marketCap: "",
            btcPrice: "",
            change: "",
            rank: 0,
            coinrankingUrl: "",
            sparkline: [""]
        )
    }
}

extension CoinDetailsModel: Mappable {
    
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        uuid <- map["uuid"]
        symbol <- map["symbol"]
        name <- map["name"]
        description <- map["description"]
        iconUrl <- map["iconUrl"]
        websiteUrl <- map["websiteUrl"]
        price <- map["price"]
        twentyFourHourVolume <- map["24hVolume"]
        marketCap <- map["marketCap"]
        btcPrice <- map["btcPrice"]
        change <- map["change"]
        rank <- map["rank"]
        coinrankingUrl <- map["coinrankingUrl"]
        sparkline <- map["sparkline"]
    }
}
