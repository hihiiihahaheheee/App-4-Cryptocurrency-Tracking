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
        configureTabBar()

    }
    
    private func configureTabBar() {
        view.backgroundColor = .white
        viewControllers = [
            configChildNavigationController(viewController: HomeViewController(), item: TabBarItems.home.item),
            configChildNavigationController(viewController: FollowsViewController(), item: TabBarItems.follows.item)
        ]
    }
    
    private func configChildNavigationController(viewController: UIViewController, item: UITabBarItem) -> UINavigationController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem = item
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }
}
