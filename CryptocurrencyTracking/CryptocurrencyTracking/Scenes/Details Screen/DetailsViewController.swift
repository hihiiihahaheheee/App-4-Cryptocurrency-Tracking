//
//  DetailsViewController.swift
//  CryptocurrencyTracking
//
//  Created by Thuận Nguyễn Văn on 01/08/2021.
//

import UIKit
import RxCocoa
import RxSwift
import NSObject_Rx

final class DetailsViewController: UIViewController {

    @IBOutlet private weak var detailsCollectionView: UICollectionView!
    
    var viewModel: DetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureCollectionView()
    }
    
    private func configureView() {
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func configureCollectionView() {
        detailsCollectionView.do {
            $0.register(cellType: DetailsCollectionViewCell.self)
        }
        configureCollectionViewLayout()
    }
    
    private func configureCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.do {
            $0.minimumLineSpacing = 0
            $0.minimumInteritemSpacing = 0
            $0.itemSize = CGSize(width: detailsCollectionView.frame.width - 30, height: 1000)
        }
        detailsCollectionView.setCollectionViewLayout(layout, animated: true)
    }
}

extension DetailsViewController: Bindable {
    func bindViewModel() {
        
        let input = DetailsViewModel.Input(loadTrigger: Driver.just(()))
        let output = viewModel.transform(input)
        
        output.loadData
            .drive()
            .disposed(by: rx.disposeBag)
        
        output.details
            .drive(detailsCollectionView.rx.items) { [weak self] (collectionView, index, details) in
                self?.title = "\(details.name) (\(details.symbol))"
                let indexPath = IndexPath(index: index)
                let cell = collectionView.dequeueReusableCell(for: indexPath,
                                                              cellType: DetailsCollectionViewCell.self)
                cell.configureCell(details: details)
                return cell
            }
            .disposed(by: rx.disposeBag)
    }
}
