//
//  DataModel.swift
//  CryptocurrencyTracking
//
//  Created by Thuận Nguyễn Văn on 31/07/2021.
//

import Foundation
import ObjectMapper
import Then

struct DataModel: Then {
    
    var coins: [CoinModel]
}

extension DataModel {
    
    init() {
        self.init(
            coins: [CoinModel()]
        )
    }
}

extension DataModel: Mappable {
    
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        coins <- map["coins"]
    }
}
