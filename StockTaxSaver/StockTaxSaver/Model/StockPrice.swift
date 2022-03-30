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

extension StockPrice: Equatable {
    
}

struct StockPriceWithDetails  {
    let symbol: String
    let description: String
    let stockPrice: StockPrice
}
