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
    let stockInfos = PublishSubject<[StockInfo]>()
    
    
    func getStockList() {
        
        let symbols = Observable.from(SaveService.shared.getList())
        var stockInfoContainer = [StockInfo]()
        
        symbols.concatMap{ symbol in
            return getStockInfoRx(symbol: symbol)
        }.subscribe(onNext: {si in
            stockInfoContainer.append(si)
            stockInfos.onNext(stockInfoContainer)
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
    
    //실패한 함수. 빈 array 를 보내준다. map 안에 API 서비스가 백그라운드에서 실행되는것을 기다리지 않고 바로 temp 를 리턴해서 발행하는 현상.
    
    func getStockInfo2() {
        
        let symbols = SaveService.shared.getList()
        
        let stockInfoList = symbols.map { symbol -> StockInfo? in
            var temp: StockInfo?
            APIService().fetchStockInfo(with: symbol) { result in
                switch result {
                case .success(let si):
                    temp = si
                case .failure(let error):
                    print(error)
                }
            }
            return temp
        }.compactMap {
            $0
        }
        print(stockInfoList)
        stockInfos.onNext(stockInfoList)
    }
    
    
}
