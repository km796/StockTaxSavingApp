//
//  StockListCell.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/03/08.
//

import Foundation
import UIKit
import Charts
import RxSwift

class StockListCell: UITableViewCell {
    
    let bag = DisposeBag()
    
    var viewModel: StockListCellVM? {
        didSet {
            configure()
        }
    }
    
    let symbol = UILabel()
    let name = UILabel()
    let open = UILabel()
    let openW = UILabel()
    let diff = UILabel()
    
    let left = UIStackView()
    let right = UIStackView()
    
    let chartView = LineChartView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        styleViews()
        layout()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func styleViews() {
        left.translatesAutoresizingMaskIntoConstraints = false
        right.translatesAutoresizingMaskIntoConstraints = false
        chartView.translatesAutoresizingMaskIntoConstraints = false
        
        left.axis = .vertical
        right.axis = .vertical
        
        diff.textAlignment = .right
        
        name.font = .systemFont(ofSize: 10)
        name.textColor = .systemGray
        name.numberOfLines = 2
        
        open.textAlignment = .right
        
        openW.textAlignment = .right
        openW.adjustsFontSizeToFitWidth = true
        openW.textColor = .darkGray
        openW.font = .systemFont(ofSize: 14)
        
        chartView.chartDescription?.enabled = false
        chartView.legend.enabled = false
        chartView.xAxis.enabled = false
        chartView.leftAxis.enabled = false
        chartView.rightAxis.enabled = false
        chartView.legend.form = .line
        chartView.setScaleEnabled(false)
        chartView.isMultipleTouchEnabled = false

    
    
    }
    
    private func layout() {
        left.addArrangedSubview(symbol)
        left.addArrangedSubview(name)
        
        right.addArrangedSubview(open)
        right.addArrangedSubview(openW)
        right.addArrangedSubview(diff)

        
        contentView.addSubview(left)
        contentView.addSubview(right)
        contentView.addSubview(chartView)
        
        NSLayoutConstraint.activate([
            left.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            left.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            left.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            
            right.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            right.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            right.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            
            
            chartView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            chartView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            chartView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            chartView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            
        ])
    }
    
    private func bind() {
        CurrencyBus.shared.currencyEvent().asDriver()
            .drive(onNext: { currency in
                guard let viewModel = self.viewModel else {
                    return
                }
                self.openW.text = "\((viewModel.openPrice*currency).rounded(toPlaces: 0))"
            }).disposed(by: bag)
    }
    
    private func configure() {
        guard let viewModel = viewModel else {
            return
        }

        symbol.text = viewModel.symbol
        name.text = viewModel.name
        open.text = "$\(viewModel.openPrice)"
        openW.text = viewModel.initialOpenW.format()
        diff.text = viewModel.diffWithSign
        diff.textColor = viewModel.diffColor
     
        
        setChart(dataPoints: viewModel.priceList.count, values: viewModel.priceList)
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
