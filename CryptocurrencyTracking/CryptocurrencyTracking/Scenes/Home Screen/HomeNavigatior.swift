//
//  HomeNavigatior.swift
//  CryptocurrencyTracking
//
//  Created by Thuận Nguyễn Văn on 31/07/2021.
//

import Foundation
import UIKit

protocol HomeNavigatorType {
    func pushDetailsViewController(coin: CoinModel)
}

struct HomeNavigator: HomeNavigatorType {
    
    unowned let navigationController: UINavigationController
    
    func pushDetailsViewController(coin: CoinModel) {
        let viewController = DetailsViewController()
        let useCase = DetailsUseCase()
        let viewModel = DetailsViewModel(useCase: useCase, coin: coin)
        viewController.bindViewModel(to: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
