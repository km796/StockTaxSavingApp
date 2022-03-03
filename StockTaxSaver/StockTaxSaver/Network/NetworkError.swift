//
//  NetworkError.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/03/03.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case requestFailed
    case networkFailed
    case decodingFailed
    case dataFailed
}
