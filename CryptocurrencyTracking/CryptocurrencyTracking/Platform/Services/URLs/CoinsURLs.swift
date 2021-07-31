//
//  CoinsURLs.swift
//  CryptocurrencyTracking
//
//  Created by Thuận Nguyễn Văn on 31/07/2021.
//

import Foundation

struct CoinsURLs {
    
    public static let shared = CoinsURLs()
    
    private var baseURL: String
    
    init() {
        baseURL = "https://api.coinranking.com/v2/"
    }
    
    public func allCoin() -> String {
        return baseURL + "/coins?limit=100"
    }
    
    public func coinDetail(uuid: String) -> String {
        return baseURL + "/coin/" + uuid
    }
    
}
