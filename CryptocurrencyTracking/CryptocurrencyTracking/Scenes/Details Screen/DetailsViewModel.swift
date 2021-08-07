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
        var timeTrigger: Driver<String>
    }
    
    struct Output {
        var title: Driver<String>
        var loadChart: Driver<[HistoryModel]>
        var details: Driver<[DetailsSectionModel]>
    }
    
    func transform(_ input: Input) -> Output {
        
        let title = input.loadTrigger
            .map { coin.name }
        
        let loadCharts = input.timeTrigger
            .flatMapLatest { timePeriod -> Driver<[HistoryModel]> in
                return useCase.getChartData(uuid: coin.uuid, timePeriod: timePeriod)
                    .asDriverOnErrorJustComplete()
            }
        
        let details = input.loadTrigger
            .flatMapLatest({ _ in
                return useCase.getCoinDetails(uuid: coin.uuid)
                    .asDriverOnErrorJustComplete()
            })
            .map { coinDetails -> [DetailsSectionModel] in
                return [.detail(items: [
                    .info(model: coinDetails),
                    .chart(model: loadCharts),
                    .detail(model: coinDetails)
                ])]
            }
        
        return Output(title: title,
                      loadChart: loadCharts,
                      details: details)
    }
}
