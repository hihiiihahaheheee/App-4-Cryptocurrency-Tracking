//
//  DetailsUseCase.swift
//  CryptocurrencyTracking
//
//  Created by Thuận Nguyễn Văn on 31/07/2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol DetailsUseCaseType {
    
    func getCoinDetails(uuid: String) -> Observable<CoinDetailsModel>
}

struct DetailsUseCase: DetailsUseCaseType {
    
    let coinRemoteRepository = CoinRemoteRepository()
    
    func getCoinDetails(uuid: String) -> Observable<CoinDetailsModel> {
        return coinRemoteRepository.getCoinDetails(uuid: uuid)
    }
}
