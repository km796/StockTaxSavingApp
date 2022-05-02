//
//  CalculatorResultCellVM.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/04/15.
//

import Foundation
import RxSwift
import UIKit

struct CalculatorResultCellVM {
    
    let result: CalculatorResult
    
    var profitSubject = BehaviorSubject<[Int]>(value: [0, 0])
    var amountSubject = BehaviorSubject<Int>(value: 0)
    
    init(result: CalculatorResult) {
        self.result = result
        amountSubject.onNext(result.amount)
    }
    
    var profitTextColor: UIColor {
        return result.profit >= 0 ? .systemIndigo : .red
    }
    
    func profitOnNext (newProfit: Int) {
        do {
            let currentProfit = try profitSubject.value()[1]
            profitSubject.onNext([currentProfit, newProfit])
        } catch {
            print("profitSubject value() error")
        }
    }
    
    func getTotalProfit(amount: Int) -> Int{
        let tot = result.profit * amount
        return tot
    }
}
