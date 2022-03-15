//
//  StockPrice.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/03/14.
//

import Foundation

struct StockPrice: Decodable {
    
    let c: [Double]
}

struct StockPriceWithSymbol {
    let symbol: String
    let stockPrice: StockPrice
}
