//
//  CalculatorResultCellVM.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/04/15.
//

import Foundation

struct CalculatorResultCellVM {
    
    var result: CalculatorResult
    
    func getTotalProfit() -> Double{
        return result.profit * Double(result.amount)
    }
}
