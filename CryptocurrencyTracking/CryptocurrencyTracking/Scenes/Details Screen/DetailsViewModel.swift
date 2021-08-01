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
    let dataSource = BehaviorRelay<[CoinDetailsModel]>(value: [CoinDetailsModel()])
}

extension DetailsViewModel: ViewModel {
    
    struct Input {
        var loadTrigger: Driver<Void>
    }
    
    struct Output {
        var loadData: Driver<Void>
        var details: Driver<[CoinDetailsModel]>
    }
    
    func transform(_ input: Input) -> Output {
        
        let loadData = input.loadTrigger
            .flatMapLatest({ _ in
                return useCase.getCoinDetails(uuid: coin.uuid)
                    .asDriverOnErrorJustComplete()
            })
            .do { coinDetails in
                return dataSource.accept([coinDetails])
            }
            .mapToVoid()
        
        return Output(loadData: loadData, details: dataSource.asDriver())
    }
}
