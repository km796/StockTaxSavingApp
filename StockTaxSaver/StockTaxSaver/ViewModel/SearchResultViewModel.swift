//
//  SearchResultViewModel.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/03/03.
//

import Foundation
import RxSwift
import RxCocoa

struct SearchResultViewModel {
    
    let searchResult = PublishSubject<[StockSearchResult]>()
    
    
    func getSearchResult(stockName: String) {
        APIService().fetchStockSearches(with: .search(symbol: stockName)) { result in
            switch result {
            case .success(let searchResponse):
                searchResult.onNext(searchResponse.bestMatches)
            case.failure(let error):
                print(error)
            }
        }
    }
    
}
