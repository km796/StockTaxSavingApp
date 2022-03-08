//
//  APIService.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/03/03.
//

import Foundation
import RxSwift
import RxCocoa

struct APIService {
    
    func fetchStockSearches(with searchQuery: String, completion: @escaping (Result<StockResponse, NetworkError>) -> Void) {
        
        guard let url = URL(string: "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(searchQuery)&apikey=\(API_KEY)") else {
            completion(.failure(.invalidURL))
            return
        }
        
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
    
    func fetchStockInfo(with symbol: String, completion: @escaping (Result<StockInfo, NetworkError>) -> Void) {
        guard let url = URL(string: "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=\(symbol)&interval=5min&apikey=\(API_KEY)") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.requestFailed))
                return
            }
            do {
                let stockInfo = try JSONDecoder().decode(StockInfo.self, from: data)
                completion(.success(stockInfo))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }.resume()
    }
}


