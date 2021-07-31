//
//  CoinsResponses.swift
//  CryptocurrencyTracking
//
//  Created by Thuận Nguyễn Văn on 31/07/2021.
//

import Foundation
import ObjectMapper
import Then

struct CoinsResponses: Then {
    
    var status: String
    var data: DataModel
}

extension CoinsResponses {
    
    init() {
        self.init(
            status: "",
            data: DataModel()
        )
    }
}

extension CoinsResponses: Mappable {
    
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        status <- map["status"]
        data <- map["data"]
    }
}
