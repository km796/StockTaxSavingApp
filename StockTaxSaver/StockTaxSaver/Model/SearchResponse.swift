//
//  SearchResponse.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/03/14.
//

import Foundation

struct SearchResponse:Decodable {
    
    let count: Int
    let result: [SearchResult]
}

struct SearchResult: Decodable {
    let description: String
    let symbol: String
}
