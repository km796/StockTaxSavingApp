//
//  StockViewModel.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/03/15.
//

import Foundation
import UIKit

struct StockViewModel {
    
    private let stock: StockPriceWithDetails
    
    var diff: Double {
        let prices = stock.stockPrice.c
        let slice = prices.suffix(2)
        let last2 = Array(slice)
        let today = last2[1]
        let yesterday = last2[0]
        let d = (today-yesterday)/yesterday * 100
        let rounded = d.rounded(toPlaces: 2)
        return rounded
    }
    
    var diffColor: UIColor {
        return diff < 0 ? .blue : .red
    }
    
    init(stock: StockPriceWithDetails) {
        self.stock = stock
    }
}
