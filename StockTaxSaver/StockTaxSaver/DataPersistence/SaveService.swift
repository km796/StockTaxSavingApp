//
//  SaveService.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/03/07.
//

import Foundation

struct SaveService {
    
    static let shared = SaveService()
    
    let userDefaults = UserDefaults.standard
    
    func addToList(symbol: String) {
        var symbols = userDefaults.stringArray(forKey: symbols_key) ?? []
        if symbols.contains(symbol) {
            return
        }
        symbols.append(symbol)
        userDefaults.set(symbols, forKey: symbols_key)
    }
    
    func getList() -> [String] {
        return userDefaults.stringArray(forKey: symbols_key) ?? []
    }
    
    private init() {
        
    }
}
