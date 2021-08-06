//
//  ChartDataModel.swift
//  CryptocurrencyTracking
//
//  Created by Thuận Nguyễn Văn on 05/08/2021.
//

import Foundation
import ObjectMapper
import Then

struct ChartDataModel: Then {
    var change: String
    var history: [HistoryModel]
}

extension ChartDataModel {
    init() {
        self.init(
            change: "",
            history: [HistoryModel]()
        )
    }
}

extension ChartDataModel: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        change <- map["change"]
        history <- map["history"]
    }
}
