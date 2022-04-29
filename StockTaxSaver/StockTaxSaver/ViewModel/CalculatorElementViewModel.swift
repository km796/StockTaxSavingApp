//
//  CalculatorElementViewModel.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/04/05.
//

import Foundation
import RxRelay
import RxCocoa

class CalculatorElementViewModel {
    
    var calculatorElement: CalculatorElement
    
    private let _deleteClicked = BehaviorRelay<Bool>(value: false)
    
    init(calculatorElement: CalculatorElement) {
        self.calculatorElement = calculatorElement
    }
    
    var deleteClicked: Driver<Bool> {
        return _deleteClicked.asDriver()
    }
    
    func setDeleteClicked() {
        _deleteClicked.accept(true)
    }
    
    func setPurchasePrice(price: String) {
        let priceDouble = Int(price) ?? 0
        calculatorElement.purchasePrice = priceDouble
    }
    
    func setCurrentPrice(price: String) {
        let priceDouble = Int(price) ?? 0
        calculatorElement.currentPrice = priceDouble
    }
}
