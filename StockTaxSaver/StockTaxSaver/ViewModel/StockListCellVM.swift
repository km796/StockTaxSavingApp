//
//  StockViewModel.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/03/15.
//

import Foundation
import UIKit

struct StockListCellVM {
    
    private let stock: StockPriceWithDetails
    
    var diff: Double {
        let prices = stock.stockPrice.c
        guard let today = prices.last, let yesterday = prices.first else {
            return 0.0
        }
        let d = (today-yesterday)/yesterday * 100
        let rounded = d.rounded(toPlaces: 2)
        return rounded
    }
    
    var diffWithSign: String {
        return diff < 0 ? "\(diff)%": "+\(diff)%"
    }
    
    var diffColor: UIColor {
        return diff < 0 ? .blue : .red
    }
    
    var symbol: String {
        return stock.symbol
    }
    
    var priceList: [Double] {
        return stock.stockPrice.c
    }
    
    var name: String {
        return symbol.description
    }
    
    var openPrice: Double {
        if let price = priceList.last {
            return price
        } else {
            return 0.0
        }
    }
    
    var initialOpenW: Int {
        return Int(CurrencyBus.shared.currency * openPrice)
    }
    
    init(stock: StockPriceWithDetails) {
        self.stock = stock
    }
}
