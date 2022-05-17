//
//  CurrencyBus.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/05/13.
//

import Foundation
import RxRelay

class CurrencyBus {
    
    static let shared = CurrencyBus()
    private let currencyRelay = BehaviorRelay<Double>(value: 0.0)
    
    private init() {}
    
    func fetchCurrency() {
        APIService().fetchCurrencyExchange(with: Endpoint.currencyExchange()) { result in
            switch result {
            case .failure(let error):
                print("currecy fetch error: \(error)")
            case .success(let currencyExchange):
                if currencyExchange.isEmpty {return}
                self.currencyRelay.accept(currencyExchange[0].basePrice)
            }
        }
    }
    
    func currencyEvent() -> BehaviorRelay<Double> {
        return currencyRelay
    }
    
    var currency: Double {
        return currencyRelay.value
    }
}
