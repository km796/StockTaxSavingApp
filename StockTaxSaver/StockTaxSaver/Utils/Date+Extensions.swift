//
//  Date+Extensions.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/04/04.
//

import Foundation

extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
    }
}
