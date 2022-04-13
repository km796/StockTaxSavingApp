//
//  CalculatorElementViewModel.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/04/05.
//

import Foundation

class CalculatorElementViewModel {
    
    var calculatorElement: CalculatorElement
    
    init(calculatorElement: CalculatorElement) {
        self.calculatorElement = calculatorElement
    }
    
    func setPurchasePrice(price: String) {
        let priceDouble = Double(price) ?? 0
        calculatorElement.purchasePrice = priceDouble
    }
    
    func setCurrentPrice(price: String) {
        let priceDouble = Double(price) ?? 0
        calculatorElement.currentPrice = priceDouble
    }
}
