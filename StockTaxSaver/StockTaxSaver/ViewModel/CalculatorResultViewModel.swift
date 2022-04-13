//
//  CalculatorResultViewModel.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/04/07.
//

import Foundation

struct CalculatorResultViewModel {
    
    var elements: [CalculatorElement]?
    
    func getResults() -> [CalculatorResult?] {
        guard let elements = elements else {
            return []
        }
        
        return elements.map({
            element in
            if let name = element.name, let purchasePrice = element.purchasePrice, let currentPrice = element.currentPrice {
                let amount = computeAmount(purchasePrice: purchasePrice, currentPrice: currentPrice)
                return CalculatorResult(name: name, amount: amount)
            } else {
                return nil
            }
        }).filter({$0 != nil})
    }
    
    func computeAmount(purchasePrice: Double, currentPrice: Double) -> Int {
        let diff = currentPrice - purchasePrice
        let amount = 2500000/diff
        
        return Int(amount)
    }

}
