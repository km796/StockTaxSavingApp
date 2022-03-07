//
//  StockInfo.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/03/07.
//

import Foundation

struct StockInfo {
    
    let meta: Meta
    let timeseries: [String: OHLCV]
}

struct Meta {
    let symbol: String
    
    enum CodingKeys: String, CodingKey {
        case symbol = "2. Symbol"
    }
}

struct OHLCV {
    let open: String
    
    enum CodingKeys: String, CodingKey {
        case open = "1. open"
    }
}
