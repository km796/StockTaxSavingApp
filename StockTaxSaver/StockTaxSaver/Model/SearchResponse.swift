//
//  SearchResponse.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/03/14.
//

import Foundation

struct SearchResponse:Decodable {
    
    let bestMatches: [StockSearchResult]
}

struct StockSearchResult: Decodable {
    
    let name: String
    let symbol: String
    let currency: String
    
    enum CodingKeys: String, CodingKey {
        case symbol = "1. symbol"
        case name = "2. name"
        case currency = "8. currency"
    }
}

