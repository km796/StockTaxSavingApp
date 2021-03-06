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
    
    func replaceList(source: Int, destination: Int) {
        var symbols = userDefaults.stringArray(forKey: symbols_key) ?? []
        if source<0 || source>=symbols.count ||  destination<0 || destination>=symbols.count {
            return
        }
        symbols.swapAt(source, destination)
        userDefaults.set(symbols, forKey: symbols_key)
    }
    
    func remove(at index: Int) {
        var symbols = userDefaults.stringArray(forKey: symbols_key) ?? []
        if index<0 || index>=symbols.count {
            return
        }
        
        symbols.remove(at: index)
        userDefaults.set(symbols, forKey: symbols_key)
    }
    
    func remove(symbol: String) {
        var symbols = userDefaults.stringArray(forKey: symbols_key) ?? []
        
        let idx = symbols.firstIndex { sym in
            sym == symbol
        }
        if let idx=idx {
            symbols.remove(at: idx)
            userDefaults.set(symbols, forKey: symbols_key)
        }
    }
    
    func getList() -> [String] {
        return userDefaults.stringArray(forKey: symbols_key) ?? []
    }
    
    func addDescription(for symbol: String, description: String) {
        userDefaults.set(description, forKey: symbol)
    }
    
    func getDescription(for symbol: String) -> String {
        return userDefaults.string(forKey: symbol) ?? ""
    }
    
    private init() {
        
    }
}
