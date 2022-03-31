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
    let stockPrices = PublishSubject<[StockPriceWithDetails]>()
    
    
    /*성공 함수. reduce 함수를 이용해 Observable의 모든 emitted events 들을 array 로 묶어 stockInfos Subject 로 넘겨주는 방식.
     reduce 는 반드시 onCompleted 후에 리턴을 하기 때문에 getObservableRx 에 onCompleted을 넣는것을 잊지말자 */
    
    func getStockList() {
        
        let symbolList = SaveService.shared.getList()
        print(symbolList)
        let symbols = Observable.from(symbolList)
        
        symbols.concatMap{ symbol -> Observable<StockInfo> in
            let obs:Observable<StockInfo> = getStockInfoRx(symbol: symbol)
            return obs
        }.reduce([]){ agg, si -> [StockInfo] in
            return agg + [si]
        }
        .subscribe(onNext: {silist in
            stockInfos.onNext(silist)
        }).disposed(by: disposeBag)
    }
    
    func getStockPriceList() {
        
        let symbolList = SaveService.shared.getList()
        print(symbolList)
        let symbols = Observable.from(symbolList)
        
        symbols.concatMap{ symbol -> Observable<StockPriceWithDetails> in
            let obs:Observable<StockPriceWithDetails> = getStockPriceRx(symbol: symbol, from: "\(DateManager().yesterdayUnix)", to: "\(DateManager().currentUnix)")
            return obs
        }.catchAndReturn(StockPriceWithDetails(symbol: "", description: "", stockPrice: StockPrice(c: [])))
        .reduce([]){ agg, si -> [StockPriceWithDetails] in
            if si.stockPrice.c.isEmpty {
                return agg
            }
            return agg + [si]
        }
        .subscribe(onNext: {silist in
            stockPrices.onNext(silist)
        }).disposed(by: disposeBag)
    }
    
    func getStockPriceRx(symbol: String, from: String, to: String) -> Observable<StockPriceWithDetails> {
        return Observable.create { observer in
            APIService().fetchStockData(with: .stockPrice(symbol: symbol, from: from, to: to)) { result in
                switch result {
                case .failure(let error):
                    observer.onError(error)
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
    
    func getStockInfoRx(symbol: String) -> Observable<StockInfo> {
        return Observable.create { observer in
            APIService().fetchStockInfo(with: symbol) { result in
                switch result {
                case .success(let si):
                    observer.onNext(si)
                    observer.onCompleted()
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
    
    //실패한 시도. stockInfoContainer 에 모든 event stream 을 모아서 그걸 publish subject 에 보내려 했지만 빈 array 가 보내짐
    func getStockList3() {
        
        let symbolList = SaveService.shared.getList()
        print(symbolList)
        let symbols = Observable.from(symbolList)
        
        var stockInfoContainer = [StockInfo]()
        
        symbols.concatMap{ symbol in
            return getStockInfoRx(symbol: symbol)
        }.subscribe(onNext: {si in
            stockInfoContainer.append(si)
        }, onCompleted: {
            stockInfos.onNext(stockInfoContainer)
        }).disposed(by: disposeBag)
    }
    
}
