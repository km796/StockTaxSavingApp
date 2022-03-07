//
//  StockListViewModel.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/03/07.
//

import Foundation

struct StockListViewModel {
    
    func getStockList() {
        
        let symbols = SaveService.shared.getList()
        symbols.flatMap({symbol in {
            
        }})
    }
}
