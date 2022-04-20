//
//  CalculatorResultCellVM.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/04/15.
//

import Foundation
import RxSwift

struct CalculatorResultCellVM {
    
    let result: CalculatorResult
    
    func getTotalProfit(amount: Int) -> Double{
        let tot = result.profit * Double(amount)
        profitSubject.onNext(tot)
        return tot
    }
    
    var profitSubject = BehaviorSubject<Double>(value: 0.0)
    var amountSubject = BehaviorSubject<Int>(value: 0)
    
    init(result: CalculatorResult) {
        self.result = result
        amountSubject.onNext(result.amount)
    }
}
