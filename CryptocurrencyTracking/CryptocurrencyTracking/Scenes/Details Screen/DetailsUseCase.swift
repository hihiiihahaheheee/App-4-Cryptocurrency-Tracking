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
    
    func getChartData(uuid: String, timePeriod: String) -> Observable<[HistoryModel]>
}

struct DetailsUseCase: DetailsUseCaseType {
    
    let coinRemoteRepository = CoinRemoteRepository()
    
    func getCoinDetails(uuid: String) -> Observable<CoinDetailsModel> {
        return coinRemoteRepository.getCoinDetails(uuid: uuid)
    }
    
    func getChartData(uuid: String, timePeriod: String) -> Observable<[HistoryModel]> {
        return coinRemoteRepository.getChartData(uuid: uuid, timePeriod: timePeriod)
    }
}
