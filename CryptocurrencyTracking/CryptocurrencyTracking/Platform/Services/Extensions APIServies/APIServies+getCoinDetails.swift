//
//  APIServies+getCoinDetails.swift
//  CryptocurrencyTracking
//
//  Created by Thuận Nguyễn Văn on 31/07/2021.
//

import Foundation
import RxCocoa
import RxSwift

extension APIServices {
    
    func getCoinDetails(uuid: String) -> Observable<CoinDetailsModel> {
        let urlRequest = CoinURLs.shared.coinDetail(uuid: uuid)
        return APIServices.shared.request(URL: urlRequest,
                                          responseType: DetailsResponsesModel.self)
            .map { detailsResponses in
                return detailsResponses.data.coin
            }
    }
    
}
