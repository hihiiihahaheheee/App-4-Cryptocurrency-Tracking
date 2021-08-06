//
//  DetailsViewModel.swift
//  CryptocurrencyTracking
//
//  Created by Thuận Nguyễn Văn on 31/07/2021.
//

import Foundation
import RxSwift
import RxCocoa

struct DetailsViewModel {
    
    let useCase: DetailsUseCaseType
    let coin: CoinModel
}

extension DetailsViewModel: ViewModel {
    
    struct Input {
        var loadTrigger: Driver<Void>
    }
    
    struct Output {
        var loadData: Driver<CoinDetailsModel>
        var details: Driver<[DetailsSectionModel]>
    }
    
    func transform(_ input: Input) -> Output {
        
        let loadDetails = input.loadTrigger
            .flatMapLatest({ _ in
                return useCase.getCoinDetails(uuid: coin.uuid)
                    .asDriverOnErrorJustComplete()
            })
        
        let loadCharts = input.loadTrigger
            .flatMapLatest { _ in
                return useCase.getChartData(uuid: coin.uuid, timePeriod: "1y")
                    .asDriverOnErrorJustComplete()
            }
        
        let details = Driver.combineLatest(loadDetails, loadCharts)
            .map { (coinDetails, history) -> [DetailsSectionModel] in
                return [.detail(items: [
                    .info(model: coinDetails),
                    .chart(model: history),
                    .detail(model: coinDetails)
                ])]
            }
        
        return Output(loadData: loadDetails, details: details)
    }
}
