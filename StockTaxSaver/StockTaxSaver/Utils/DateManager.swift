//
//  DateManager.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/03/18.
//

import Foundation

struct DateManager {
    
    var currentUnix: Int {
        return Date().timeIntervalSince1970.toInt() ?? 0
    }
    
    var yesterdayUnix: Int {
        return currentUnix - 86400
    }
}
