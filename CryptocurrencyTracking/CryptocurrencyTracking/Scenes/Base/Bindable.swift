//
//  Bindable.swift
//  CryptocurrencyTracking
//
//  Created by Thuận Nguyễn Văn on 31/07/2021.
//

import Foundation
import UIKit

public protocol Bindable: AnyObject {

    associatedtype ViewModel

    var viewModel: Self.ViewModel! { get set }

    func bindViewModel()
}

extension Bindable where Self: UIViewController {

    public func bindViewModel(to model: Self.ViewModel) {
        viewModel = model
        loadViewIfNeeded()
        bindViewModel()
    }
}
