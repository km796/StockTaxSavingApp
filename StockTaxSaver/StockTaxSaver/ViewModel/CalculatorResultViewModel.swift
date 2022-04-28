//
//  CalculatorResultViewModel.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/04/07.
//

import Foundation

struct CalculatorResultViewModel {
    
    var elements: [CalculatorElement]?

    func getValidElements() -> [CalculatorElement] {
        guard let elements = elements else {
            return []
        }
        
        return elements.filter {
            $0.name != nil && $0.purchasePrice != nil && $0.currentPrice != nil
        }
    }
    
    func getResults() -> [CalculatorResultCellVM] {
        guard let elements = elements else {
            return []
        }
        
        return elements.map({
            element in
            if let name = element.name, let purchasePrice = element.purchasePrice, let currentPrice = element.currentPrice {
                let profit = currentPrice - purchasePrice
                let result = CalculatorResult(name: name, amount: 0, profit: profit)
                return CalculatorResultCellVM(result: result)
            } else {
                return nil
            }
        }).compactMap{$0}
    }
    
}
