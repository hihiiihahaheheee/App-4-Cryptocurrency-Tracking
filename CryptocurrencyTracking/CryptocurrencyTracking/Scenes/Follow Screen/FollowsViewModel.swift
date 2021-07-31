//
//  FollowsViewModel.swift
//  CryptocurrencyTracking
//
//  Created by Thuận Nguyễn Văn on 31/07/2021.
//

import Foundation

struct FollowsViewModel {
    
    let useCase: FollowsUseCaseType
    let navigator: FollowsNavigatorType
}

extension FollowsViewModel: ViewModel {
    
    struct Input {
        
    }
    
    struct Output {
        
    }
    
    func transform(_ input: Input) -> Output {
        return Output()
    }
}
