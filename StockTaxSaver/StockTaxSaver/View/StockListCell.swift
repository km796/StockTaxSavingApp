//
//  StockListCell.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/03/08.
//

import Foundation
import UIKit

class StockListCell: UITableViewCell {
    
    var stockInfo: StockInfo? {
        didSet {
            configure()
        }
    }
    
    let name = UILabel()
    let open = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        styleViews()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func styleViews() {
        
    }
    
    private func layout() {
        addSubview(name)
        addSubview(open)
        
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            name.leftAnchor.constraint(equalTo: leftAnchor, constant: 4),
            
            open.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            open.rightAnchor.constraint(equalTo: rightAnchor, constant: 4)
        ])
    }
    
    private func configure() {
        guard let stockInfo = stockInfo else {
            return
        }
        
        name.text = stockInfo.meta.symbol
        guard let key = stockInfo.timeseries.keys.first else { return  }
        guard let ohlv = stockInfo.timeseries[key] else { return }
        open.text = ohlv.open
    }
}
