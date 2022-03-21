//
//  Double+Extensions.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/03/15.
//

import Foundation

extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    func toInt() -> Int? {
          let roundedValue = rounded(.toNearestOrEven)
          return Int(exactly: roundedValue)
      }
}
