//
//  APIService.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/03/03.
//

import Foundation

struct APIService {
    
    typealias APICompletion = (Result<StockResponse, NetworkError>) -> Void
    
    func fetchStockSearches(with searchQuery: String, completion: @escaping APICompletion) {
        
        let url = URL(string: "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(searchQuery)&apikey=\(API_KEY)")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.requestFailed))
                return
            }
            
            do {
                let searchResponse = try JSONDecoder().decode(StockResponse.self, from: data)
                completion(.success(searchResponse))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }.resume()
    }
}


