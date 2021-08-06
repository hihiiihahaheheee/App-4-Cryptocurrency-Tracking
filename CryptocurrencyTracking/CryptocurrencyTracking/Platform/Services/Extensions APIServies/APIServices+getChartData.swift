//
//  APIServices+getChartData.swift
//  CryptocurrencyTracking
//
//  Created by Thuận Nguyễn Văn on 05/08/2021.
//

import Foundation
import RxSwift
import RxCocoa

extension APIServices {
    
    func getChartData(uuid: String, timePeriod: String) -> Observable<[HistoryModel]> {
        let urlRequest = CoinURLs.shared.chartData(uuid: uuid, timePeriod: timePeriod)
        return APIServices.shared.request(URL: urlRequest, responseType: ChartResponseModel.self)
            .map { chartResponse in
                return chartResponse.data.history
            }
    }
}
