//
//  TabBarItems.swift
//  CryptocurrencyTracking
//
//  Created by Thuận Nguyễn Văn on 31/07/2021.
//

import Foundation
import UIKit

enum TabBarItems {
    
    case home
    case follows
    
    var item: UITabBarItem {
        switch self {
        case .home:
            return UITabBarItem(title: L10n.homeTitle,
                                image: Asset.unTappedHome.image,
                                selectedImage: Asset.tappedHome.image.withRenderingMode(.alwaysOriginal))
        case .follows:
            return UITabBarItem(title: L10n.followsTitle,
                                image: Asset.unTappedFollows.image,
                                selectedImage: Asset.tappedFollows.image.withRenderingMode(.alwaysOriginal))
        }
    }
}
