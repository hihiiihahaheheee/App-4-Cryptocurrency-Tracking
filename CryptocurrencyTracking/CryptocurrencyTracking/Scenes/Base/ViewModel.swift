//
//  ViewModel.swift
//  CryptocurrencyTracking
//
//  Created by Thuận Nguyễn Văn on 31/07/2021.
//

import Foundation
import RxSwift

public protocol ViewModel {
    
    associatedtype Input
    associatedtype Output
    
    func transform(_ input: Input) -> Output
}
