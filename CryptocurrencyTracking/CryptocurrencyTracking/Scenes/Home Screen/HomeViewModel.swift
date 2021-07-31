//
//  HomeViewModel.swift
//  CryptocurrencyTracking
//
//  Created by Thuận Nguyễn Văn on 31/07/2021.
//

import Foundation

struct HomeViewModel {
    
    let useCase: HomeUseCaseType
    let navigator: HomeNavigatorType
}

extension HomeViewModel: ViewModel {
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    public func transform(_ input: Input) -> Output {
        return Output()
    }
}
