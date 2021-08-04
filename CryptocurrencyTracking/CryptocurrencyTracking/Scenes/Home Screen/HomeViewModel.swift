//
//  HomeViewModel.swift
//  CryptocurrencyTracking
//
//  Created by Thuận Nguyễn Văn on 31/07/2021.
//

import Foundation
import RxCocoa
import RxSwift

struct HomeViewModel {
    
    let useCase: HomeUseCaseType
    let navigator: HomeNavigatorType
}

extension HomeViewModel: ViewModel {
    
    struct Input {
        var loadTrigger: Driver<Void>
        var selectTrigger: Driver<IndexPath>
        var searchTrigger: Driver<String>
    }
    
    struct Output {
        var coins: Driver<[CoinModel]>
        var voidDrivers: [Driver<Void>]
    }
    
    public func transform(_ input: Input) -> Output {
        
        var tempDataForSearch = [CoinModel]()
        let dataSource = BehaviorRelay<[CoinModel]>(value: [CoinModel()])
        
        let coins = input.loadTrigger
            .flatMapLatest { _ in
                return useCase.getAllCoin()
                    .asDriverOnErrorJustComplete()
            }
            .do { data in
                dataSource.accept(data)
                tempDataForSearch = data
            }
        
        let selected = input.selectTrigger
            .withLatestFrom(coins) { indexPath, coins in
                return coins[indexPath.row]
            }
            .do(onNext: navigator.pushDetailsViewController(coin:))
            .mapToVoid()
        
        let searched = input.searchTrigger
            .do { query in
                if !query.isEmpty {
                    dataSource.accept(tempDataForSearch.filter {
                        $0.name.contains(query) || $0.symbol.contains(query)
                    })
                } else {
                    dataSource.accept(tempDataForSearch)
                }
            }
            .mapToVoid()
        
        let voidDrivers = [selected, searched]

        return Output(coins: dataSource.asDriver(),
                      voidDrivers: voidDrivers)
    }
}
