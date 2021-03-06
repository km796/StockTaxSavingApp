//
//  StockListViewModel.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/03/07.
//

import Foundation
import RxSwift
import RxRelay

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

    
    
    
    //????????? ??????. ??? array ??? ????????????. map ?????? API ???????????? ????????????????????? ?????????????????? ???????????? ?????? ?????? temp ??? ???????????? ???????????? ??????.
    
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
    
    //????????? ??????. stockInfoContainer ??? ?????? event stream ??? ????????? ?????? publish subject ??? ????????? ????????? ??? array ??? ?????????
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
