//
//  DateManager.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/03/18.
//

import Foundation

let unix1Hour = 3600
let unix1Day = 86400
let unix1Week = 604800

struct DateManager {
    
    var currentUnix: Int {
        return Date().timeIntervalSince1970.toInt() ?? 0
    }
    
    var yesterdayUnix: Int {
        switch Date().dayOfWeek() {
        case "Monday":
            return currentUnix - unix1Day*4
        case "Sunday":
            return currentUnix - unix1Day*3
        case "Saturday":
            return currentUnix - unix1Day*2
        default:
            return currentUnix - unix1Day
        }
    }
}
