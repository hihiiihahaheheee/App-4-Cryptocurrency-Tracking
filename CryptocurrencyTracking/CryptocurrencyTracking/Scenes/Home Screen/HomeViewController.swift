//
//  HomeViewController.swift
//  CryptocurrencyTracking
//
//  Created by Thuận Nguyễn Văn on 31/07/2021.
//

import UIKit

final class HomeViewController: UIViewController {
    
    @IBOutlet private weak var coinsCollectionView: UICollectionView!
    
    var viewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureCollectionView()
    }
    
    private func configureView() {
        
    }
    
    private func configureCollectionView() {
        
    }
}

extension HomeViewController: Bindable {
    
    public func bindViewModel() {
        
    }
}
