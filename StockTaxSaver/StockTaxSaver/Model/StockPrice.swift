//
//  StockPrice.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/03/14.
//

import Foundation
import RxDataSources

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

extension StockPriceWithDetails: Equatable {
    static func == (lhs: StockPriceWithDetails, rhs: StockPriceWithDetails) -> Bool {
        return lhs.symbol == rhs.symbol &&
        lhs.description == rhs.description &&
        lhs.stockPrice == rhs.stockPrice
    }
    
}


extension StockPriceWithDetails : IdentifiableType {
    var identity: String {
        return self.description
    }
    
    typealias Identity = String
}
