//
//  SearchResultCellVM.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/05/02.
//

import Foundation
import UIKit
import RxSwift
import RxRelay
import RxCocoa

struct SearchResultCellVM {
    
    let bag = DisposeBag()
    
    let searchResult: StockSearchResult
    
    init(searchResult: StockSearchResult) {
        self.searchResult = searchResult
        
        let symbolsList = SaveService.shared.getList()
        if symbolsList.contains(searchResult.symbol) {
            setButtonChecked(checked: true)
        } else {
            setButtonChecked(checked: false)
        }
        
        bind()
    }
    
    private let _buttonChecked = BehaviorRelay<Bool>(value: false)

    var buttonChecked: Driver<Bool> {
        return _buttonChecked.asDriver()
    }
    
    var buttonState: Bool {
        return _buttonChecked.value
    }
    
    func setButtonChecked(checked: Bool) {
        _buttonChecked.accept(checked)
    }
    
    private func bind() {
        buttonChecked.drive(onNext: {
            checked in
            if checked {
                SaveService.shared.addToList(symbol: searchResult.symbol)
                SaveService.shared.addDescription(for: searchResult.symbol, description: searchResult.name)
            } else {
                SaveService.shared.remove(symbol: searchResult.symbol)
            }
        }).disposed(by: bag)
    }
    
}
