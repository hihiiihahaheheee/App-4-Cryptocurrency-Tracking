//
//  TabBarViewController.swift
//  CryptocurrencyTracking
//
//  Created by Thuận Nguyễn Văn on 31/07/2021.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()

    }
    
    private func configureView() {
        tabBar.do {
            $0.backgroundColor = .secondarySystemBackground
            $0.clipsToBounds = true
        }
        
        viewControllers = [
            createHomeNavigationController(),
            createFollowsNavigationController()
        ]
    }
    
    private func createHomeNavigationController() -> UINavigationController {
        let viewController = HomeViewController()
        viewController.tabBarItem = TabBarItems.home.item
        let navigationController = BaseNavigationController(rootViewController: viewController)
        let useCase = HomeUseCase(coinRemoteRepository: CoinRemoteRepository())
        let navigator = HomeNavigator(navigationController: navigationController)
        let viewModel = HomeViewModel(useCase: useCase, navigator: navigator)
        viewController.bindViewModel(to: viewModel)
        return navigationController
    }
    
    private func createFollowsNavigationController() -> UINavigationController {
        let viewController = FollowsViewController()
        viewController.tabBarItem = TabBarItems.follows.item
        let navigationController = BaseNavigationController(rootViewController: viewController)
        let useCase = FollowsUseCase()
        let navigator = FollowsNavigator()
        let viewModel = FollowsViewModel(useCase: useCase, navigator: navigator)
        viewController.bindViewModel(to: viewModel)
        return navigationController
    }
}
