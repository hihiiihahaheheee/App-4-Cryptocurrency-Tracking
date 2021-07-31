//
//  BaseNavigationController.swift
//  CryptocurrencyTracking
//
//  Created by Thuận Nguyễn Văn on 31/07/2021.
//

import Foundation
import UIKit

final class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        delegate = self
        navigationBar.do {
            $0.isTranslucent = false
            $0.backgroundColor = .white
        }
    }
}

extension BaseNavigationController: UINavigationControllerDelegate {
    
}
