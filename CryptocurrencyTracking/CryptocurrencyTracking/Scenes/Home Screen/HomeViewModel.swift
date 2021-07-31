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
        
        let selected = input.selectTrigger
            .withLatestFrom(coins) { indexPath, coins in
                return coins[indexPath.row]
            }
            .do(onNext: navigator.pushDetailsViewController(coin:))
            .mapToVoid()
        
        return Output(coins: coins, selected: selected)
    }
}
