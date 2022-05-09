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
    let stockPrices = PublishSubject<[StockPriceWithDetails]>()
    
    func getStockPriceList() {
        
        let symbolList = SaveService.shared.getList()
        print(symbolList)
        let symbols = Observable.from(symbolList)
        var dic = [String: StockPriceWithDetails]()
        
        symbols.flatMap{ symbol -> Observable<StockPriceWithDetails> in
            let obs:Observable<StockPriceWithDetails> = getStockPriceRx(symbol: symbol, from: "\(DateManager().yesterdayUnix)", to: "\(DateManager().currentUnix)")
            return obs
        }
        .subscribe(onNext: {stock in
            dic[stock.symbol] = stock
        },
        onError: { error in
            print(error)
        }, onCompleted: {
            let res:[StockPriceWithDetails] = symbolList.map {dic[$0]}.compactMap{$0}
            stockPrices.onNext(res)
        }).disposed(by: disposeBag)
        
    }
    
    func getStockPriceRx(symbol: String, from: String, to: String) -> Observable<StockPriceWithDetails> {
        return Observable.create { observer in
            APIService().fetchStockData(with: .stockPrice(symbol: symbol, from: from, to: to)) { result in
                switch result {
                case .failure(let error):
                    print("\(error) " + symbol)
                    SaveService.shared.remove(symbol: symbol)
                    observer.onCompleted()
                case .success(let si):
                    let desc = SaveService.shared.getDescription(for: symbol)
                    observer.onNext(StockPriceWithDetails(symbol: symbol, description: desc, stockPrice: si))
                    observer.onCompleted()
                }
            }
            
            return Disposables.create()
        }
    }
    
    func reorderSymbols(source: Int, destination: Int) {
        SaveService.shared.replaceList(source: source, destination: destination)
    }
    
    func removeSymbols(at index: Int) {
        SaveService.shared.remove(at: index)
    }
    
    func isSymbolsListEmpty() -> Bool {
        return SaveService.shared.getList().isEmpty
    }
    
    
    
    
    //실패한 함수. 빈 array 를 보내준다. map 안에 API 서비스가 백그라운드에서 실행되는것을 기다리지 않고 바로 temp 를 리턴해서 발행하는 현상.
    
//    func getStockInfo2() {
//
//        let symbols = SaveService.shared.getList()
//
//        let stockInfoList = symbols.map { symbol -> StockInfo? in
//            var temp: StockInfo?
//            APIService().fetchStockInfo(with: symbol) { result in
//                switch result {
//                case .success(let si):
//                    temp = si
//                case .failure(let error):
//                    print(error)
//                }
//            }
//            return temp
//        }.compactMap {
//            $0
//        }
//        print(stockInfoList)
//        stockInfos.onNext(stockInfoList)
//    }
    
    //실패한 시도. stockInfoContainer 에 모든 event stream 을 모아서 그걸 publish subject 에 보내려 했지만 빈 array 가 보내짐
//    func getStockList3() {
//
//        let symbolList = SaveService.shared.getList()
//        print(symbolList)
//        let symbols = Observable.from(symbolList)
//
//        var stockInfoContainer = [StockInfo]()
//
//        symbols.concatMap{ symbol in
//            return getStockInfoRx(symbol: symbol)
//        }.subscribe(onNext: {si in
//            stockInfoContainer.append(si)
//        }, onCompleted: {
//            stockInfos.onNext(stockInfoContainer)
//        }).disposed(by: disposeBag)
//    }
    
}
