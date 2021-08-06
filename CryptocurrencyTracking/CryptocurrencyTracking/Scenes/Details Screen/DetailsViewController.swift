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
import RxDataSources

final class DetailsViewController: UIViewController {

    @IBOutlet private weak var detailsCollectionView: UICollectionView!
    
    typealias DataSource = RxCollectionViewSectionedReloadDataSource<DetailsSectionModel>
    private var dataSource: DataSource!
    
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
            $0.register(cellType: InfoCollectionViewCell.self)
            $0.register(cellType: ChartCollectionViewCell.self)
            $0.register(cellType: DetailsCollectionViewCell.self)
            $0.rx.setDelegate(self)
                .disposed(by: rx.disposeBag)
        }
        setupDataSource()
    }
    
    private func setupDataSource() {
        dataSource = DataSource(configureCell: configureCell)
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
            .drive(detailsCollectionView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
    }
}

extension DetailsViewController {
    private var configureCell: DataSource.ConfigureCell {
        return { (dataSource, collectionView, indexPath, _) in
            switch dataSource[indexPath] {
            case .info(let model):
                let cell = collectionView.dequeueReusableCell(for: indexPath,
                                                              cellType: InfoCollectionViewCell.self)
                cell.configureCell(coinDetails: model)
                return cell
            case .chart( _ ):
                let cell = collectionView.dequeueReusableCell(for: indexPath,
                                                              cellType: ChartCollectionViewCell.self)
                cell.backgroundColor = .green
                return cell
            case .detail( _ ):
                let cell = collectionView.dequeueReusableCell(for: indexPath,
                                                              cellType: DetailsCollectionViewCell.self)
                cell.backgroundColor = .yellow
                return cell
            }
        }
    }
}

extension DetailsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch dataSource[indexPath] {
        case .info:
            return CGSize(width: detailsCollectionView.frame.width, height: 130)
        case .chart:
            return CGSize(width: detailsCollectionView.frame.width - 30, height: 600)
        case .detail:
            return CGSize(width: detailsCollectionView.frame.width - 30, height: 400)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
