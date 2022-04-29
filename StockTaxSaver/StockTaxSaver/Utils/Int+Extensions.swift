//
//  Int+Extensions.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/04/28.
//

import Foundation

extension Int {
    
    func format() -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let formattedNumber = numberFormatter.string(from: NSNumber(value:self)) ?? ""
        return formattedNumber + " 원"
    }
}
