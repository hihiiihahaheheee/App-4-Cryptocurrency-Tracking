//
//  HomeViewController.swift
//  CryptocurrencyTracking
//
//  Created by Thuận Nguyễn Văn on 31/07/2021.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx
import Reusable

final class HomeViewController: UIViewController {
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var coinsCollectionView: UICollectionView!
    
    var viewModel: HomeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureCollectionView()
    }
    
    private func configureView() {
        title = L10n.homeTitle
        view.backgroundColor = .secondarySystemBackground
        searchBar.placeholder = "  Find an markets"
    }
    
    private func configureCollectionView() {
        coinsCollectionView.do {
            $0.register(cellType: CoinCollectionViewCell.self)
            $0.backgroundColor = .secondarySystemBackground
        }
        configureCollectionViewLayout()
    }
    
    private func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.do {
            $0.minimumLineSpacing = 10
            $0.minimumInteritemSpacing = 0
            $0.itemSize = CGSize(width: coinsCollectionView.frame.width - 40,
                                 height: 130)
            $0.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        coinsCollectionView.setCollectionViewLayout(layout, animated: true)
    }
}

extension HomeViewController: Bindable {
    
    public func bindViewModel() {
        
        let input = HomeViewModel.Input(loadTrigger: Driver.just(()),
                                        selectTrigger: coinsCollectionView.rx.itemSelected
                                            .asDriver(),
                                        searchTrigger: searchBar.rx.text.orEmpty.asDriver())
        let output = viewModel.transform(input)
        
        output.coins
            .drive(coinsCollectionView.rx.items) { collectionView, index, coin in
                let indexPath = IndexPath(index: index)
                let cell = collectionView.dequeueReusableCell(for: indexPath,
                                                              cellType: CoinCollectionViewCell.self)
                cell.configureCell(coin: coin)
                return cell
            }
            .disposed(by: rx.disposeBag)
        
        output.selected
            .drive()
            .disposed(by: rx.disposeBag)
    }
}
