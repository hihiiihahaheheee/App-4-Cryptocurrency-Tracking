//
//  CoinRemoteRepository.swift
//  CryptocurrencyTracking
//
//  Created by Thuận Nguyễn Văn on 31/07/2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol CoinRemoteRepositoryType {
    
    func getAllCoin() -> Observable<[CoinModel]>
}

struct CoinRemoteRepository: CoinRemoteRepositoryType {
    
    func getAllCoin() -> Observable<[CoinModel]> {
        let urlRequest = CoinURLs.shared.allCoin()
        return APIServices.shared.request(URL: urlRequest, responseType: CoinsResponses.self)
            .map { coinsResponses in
                return coinsResponses.data.coins
            }
    }
}
