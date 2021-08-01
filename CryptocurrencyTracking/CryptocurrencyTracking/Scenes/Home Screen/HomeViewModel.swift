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
    let dataSource = BehaviorRelay<[CoinModel]>(value: [CoinModel()])
}

extension HomeViewModel: ViewModel {
    
    struct Input {
        var loadTrigger: Driver<Void>
        var selectTrigger: Driver<IndexPath>
        var searchTrigger: Driver<String>
    }
    
    struct Output {
        var coins: Driver<[CoinModel]>
        var selected: Driver<Void>
    }
    
    public func transform(_ input: Input) -> Output {
        
        let coins = input.loadTrigger
            .flatMapLatest { _ in
                return useCase.getAllCoin()
                    .asDriverOnErrorJustComplete()
            }
            .do(onNext: dataSource.accept(_:))
        
        let selected = input.selectTrigger
            .withLatestFrom(coins) { indexPath, coins in
                return coins[indexPath.row]
            }
            .do(onNext: navigator.pushDetailsViewController(coin:))
            .mapToVoid()
        
        return Output(coins: dataSource.asDriver(),
                      selected: selected)
    }
}
