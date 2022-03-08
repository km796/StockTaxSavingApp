//
//  StockListViewModel.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/03/07.
//

import Foundation
import RxSwift

struct StockListViewModel {
    
    let disposeBag = DisposeBag()
    
    func getStockList() {
        
        let symbols = Observable.from(SaveService.shared.getList())
        
        symbols.flatMap{symbol in
            return getStockInfoRx(symbol: symbol)
        }.subscribe(onNext: { stockInfo in
            print(stockInfo)
        }).disposed(by: disposeBag)
        
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
