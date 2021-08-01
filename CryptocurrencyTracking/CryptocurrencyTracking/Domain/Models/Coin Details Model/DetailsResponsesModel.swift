//
//  DetailsResponsesModel.swift
//  CryptocurrencyTracking
//
//  Created by Thuận Nguyễn Văn on 01/08/2021.
//

import Foundation
import ObjectMapper
import Then

struct DetailsResponsesModel {
    var status: String
    var data: DetailsDataModel
}

extension DetailsResponsesModel {
    init() {
        self.init(status: "",
                  data: DetailsDataModel())
    }
}

extension DetailsResponsesModel: Mappable {
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        status <- map["status"]
        data <- map["data"]
    }
}
