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

    
    func fetchStockSearches(with endpoint: Endpoint, completion: @escaping (Result<SearchResponse, NetworkError>) -> Void) {
        
        guard let url = endpoint.url else {
            completion(.failure(.invalidURL))
            return
        }
        print(url)
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.requestFailed))
                return
            }
            
            do {
                let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                completion(.success(searchResponse))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }.resume()
    }
    
    func fetchStockData(with endpoint: Endpoint,  completion: @escaping (Result<StockPrice, NetworkError>) -> Void) {
        guard let url = endpoint.url else {
            completion(.failure(.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.requestFailed))
                return
            }
            do {
                let stockInfo = try JSONDecoder().decode(StockPrice.self, from: data)
                completion(.success(stockInfo))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }.resume()
        
    }
}


