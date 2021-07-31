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
            $0.backgroundColor = .white
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
        let useCase = HomeUseCase()
        let navigator = HomeNavigator()
        let viewModel = HomeViewModel(useCase: useCase, navigator: navigator)
        viewController.bindViewModel(to: viewModel)
        let navigationController = BaseNavigationController(rootViewController: viewController)
        return navigationController
    }
    
    private func createFollowsNavigationController() -> UINavigationController {
        let viewController = FollowsViewController()
        viewController.tabBarItem = TabBarItems.follows.item
        let useCase = FollowsUseCase()
        let navigator = FollowsNavigator()
        let viewModel = FollowsViewModel(useCase: useCase, navigator: navigator)
        viewController.bindViewModel(to: viewModel)
        let navigationController = BaseNavigationController(rootViewController: viewController)
        return navigationController
    }
}
