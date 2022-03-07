//
//  StockInfo.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/03/07.
//

import Foundation

struct StockInfo: Decodable {
    
    let meta: Meta
    let timeseries: [String: OHLCV]
    
    enum  CodingKeys: String, CodingKey {
        case meta = "Meta Data"
        case timeseries = "Time Series (5min)"
    }
}

struct Meta: Decodable {
    let symbol: String
    
    enum CodingKeys: String, CodingKey {
        case symbol = "2. Symbol"
    }
}

struct OHLCV: Decodable {
    let open: String
    
    enum CodingKeys: String, CodingKey {
        case open = "1. open"
    }
}
