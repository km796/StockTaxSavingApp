//
//  StockListViewModel.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/03/07.
//

import Foundation
import RxSwift

struct StockListViewModel {
    
    
    func getStockList() -> Observable<StockInfo> {
        
        let symbols = Observable.from(SaveService.shared.getList())

        return symbols.flatMap{ symbol in
            return getStockInfoRx(symbol: symbol)
        }
        
//        let symbols = SaveService.shared.getList()
//        let allObsrvables = symbols.map {
//            getStockInfoRx(symbol: $0)
//        }
//
    }
    
    func getStockInfoRx(symbol: String) -> Observable<StockInfo> {
        return Observable.create { observer in
            APIService().fetchStockInfo(with: symbol) { result in
                switch result {
                case .success(let si):
                    observer.onNext(si)
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
