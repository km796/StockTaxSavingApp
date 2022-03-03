//
//  APIService.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/03/03.
//

import Foundation

struct APIService<T> {
    
    typealias APICompletion = (Result<T, NetworkError>) -> Void
    
    func fetchStockSearches(searchQuery: String, completion: @escaping APICompletion) {
        
        let url = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(searchQuery)&apikey=\(API_KEY)"
        
        
    }
}


