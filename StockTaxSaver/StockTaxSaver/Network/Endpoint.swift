//
//  Endpoint.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/03/14.
//

import Foundation

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
    let host: String
}

extension Endpoint {
    static func search(symbol: String) -> Endpoint {
        return Endpoint(
            path: "/query",
            queryItems: [
                URLQueryItem(name: "function", value: "SYMBOL_SEARCH"),
                URLQueryItem(name: "keywords", value: symbol),
                URLQueryItem(name: "apikey", value: searchAPI_KEY)
            ], host: "alphavantage.co")
    }
    
    static func stockPrice(symbol: String, from:String, to:String)->Endpoint{
        return Endpoint(
            path: "/api/v1/stock/candle",
            queryItems: [
                URLQueryItem(name: "symbol", value: symbol),
                URLQueryItem(name: "resolution", value: "30"),
                URLQueryItem(name: "from", value: from ),
                URLQueryItem(name: "to", value: to),
                URLQueryItem(name: "token", value: API_KEY)
            ], host: "finnhub.io")
    }
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = host
        components.path = path
        components.queryItems = queryItems
    
        return components.url
    }
}
