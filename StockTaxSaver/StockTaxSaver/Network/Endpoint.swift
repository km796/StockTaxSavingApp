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
}

extension Endpoint {
    static func search(symbol: String) -> Endpoint {
        return Endpoint(
            path: "/api/v1/search",
            queryItems: [
                URLQueryItem(name: "q", value: symbol)
            ])
    }
    
    static func stockPrice(symbol: String, from:String, to:String)->Endpoint{
        return Endpoint(
            path: "/api/v1/stock/candle",
            queryItems: [
                URLQueryItem(name: "symbol", value: symbol),
                URLQueryItem(name: "resolution", value: "D"),
                URLQueryItem(name: "from", value: from ),
                URLQueryItem(name: "to", value: to)
            ])
    }
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "finnhub.io"
        components.path = path
        let queryItemsWithKey = queryItems + [URLQueryItem(name: "token", value: API_KEY)]
        components.queryItems = queryItemsWithKey
    
        return components.url
    }
}
