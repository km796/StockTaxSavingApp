//
//  StockListCell.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/03/08.
//

import Foundation
import UIKit
import Charts

class StockListCell: UITableViewCell {
    
//    var stockInfo: StockInfo? {
//        didSet {
//            configure()
//        }
//    }
//
    var stockPrice: StockPriceWithSymbol? {
        didSet {
            configure()
        }
    }
    
    let symbol = UILabel()
    let name = UILabel()
    let open = UILabel()
    
    let chartView = LineChartView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        styleViews()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func styleViews() {
        symbol.translatesAutoresizingMaskIntoConstraints = false
        open.translatesAutoresizingMaskIntoConstraints = false
        chartView.translatesAutoresizingMaskIntoConstraints = false
        
        open.textAlignment = .right
        
        chartView.chartDescription?.enabled = false
        chartView.legend.enabled = false
        chartView.xAxis.enabled = false
        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
        chartView.legend.form = .line
    
    
    }
    
    private func layout() {
        addSubview(symbol)
        addSubview(open)
        addSubview(chartView)
        
        NSLayoutConstraint.activate([
            symbol.centerYAnchor.constraint(equalTo: centerYAnchor),
            symbol.leftAnchor.constraint(equalTo: leftAnchor, constant: 4),
            symbol.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),
            
            open.centerYAnchor.constraint(equalTo: centerYAnchor),
            open.rightAnchor.constraint(equalTo: rightAnchor, constant: -4),
            open.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2),
            
            chartView.centerXAnchor.constraint(equalTo: centerXAnchor),
            chartView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            chartView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            chartView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8)
        ])
    }
    
    private func configure() {
//        guard let stockInfo = stockInfo else {
//            return
//        }
//
//        symbol.text = stockInfo.meta.symbol
//        guard let key = stockInfo.timeseries.keys.first else { return  }
//        guard let ohlv = stockInfo.timeseries[key] else { return }
//        open.text = ohlv.open
//
//        let keyList = stockInfo.timeseries.keys.sorted(by: {$0 > $1})
//        let values = keyList.compactMap {
//            stockInfo.timeseries[$0]
//        }.compactMap {Double($0.open)}
//
//
//        setChart(dataPoints: keyList, values: values)
        
        guard let stockPrice = stockPrice else {
            return
        }
        let symbolText = stockPrice.symbol
        let priceList = stockPrice.stockPrice.c
        
        symbol.text = symbolText
        if let price = priceList.first {
            open.text = "\(price)"
        }
        
        setChart(dataPoints: priceList.count, values: priceList)
    }
    
    func setChart(dataPoints: Int, values: [Double]) {
            
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints {
            let dataEntry = ChartDataEntry(x: Double(i), y: values[i])
            dataEntries.append(dataEntry)
        }
        
        
        let lineChartDataSet = LineChartDataSet(entries: dataEntries, label: nil)
        lineChartDataSet.drawValuesEnabled = false
        lineChartDataSet.drawCirclesEnabled = false
        lineChartDataSet.drawIconsEnabled = false
        lineChartDataSet.lineWidth = 3
    
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        chartView.data = lineChartData
        
    }
}
