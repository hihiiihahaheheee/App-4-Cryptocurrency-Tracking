//
//  ChartResponseModel.swift
//  CryptocurrencyTracking
//
//  Created by Thuận Nguyễn Văn on 05/08/2021.
//

import Foundation
import ObjectMapper
import Then

struct ChartResponseModel: Then {
    var status: String
    var data: ChartDataModel
}

extension ChartResponseModel {
    init() {
        self.init(
            status: "",
            data: ChartDataModel()
        )
    }
}

extension ChartResponseModel: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        status <- map["status"]
        data <- map["data"]
    }
}
