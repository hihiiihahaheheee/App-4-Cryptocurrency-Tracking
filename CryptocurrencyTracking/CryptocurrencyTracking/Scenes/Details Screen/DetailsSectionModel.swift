//
//  DetailsSectionModel.swift
//  CryptocurrencyTracking
//
//  Created by Thuận Nguyễn Văn on 05/08/2021.
//

import Foundation
import RxDataSources
import UIKit
import RxCocoa
import RxSwift

enum DetailsSectionModel {
    case detail(items: [SectionItems])
}

enum SectionItems {
    case info(model: CoinDetailsModel)
    case chart(model: Driver<[HistoryModel]>)
    case detail(model: CoinDetailsModel)
}

extension DetailsSectionModel: SectionModelType {
    
    typealias Item = SectionItems
    
    var items: [SectionItems] {
        switch self {
        case .detail(let items):
            return items.map { $0 }
        }
    }
    
    init(original: DetailsSectionModel, items: [Item]) {
        switch original {
        case .detail:
            self = .detail(items: items)
        }
    }
}
