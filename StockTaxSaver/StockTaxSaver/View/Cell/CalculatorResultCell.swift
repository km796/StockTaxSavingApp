//
//  CalculatorResultCell.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/04/07.
//

import Foundation
import UIKit

class CalculatorResultCell: UITableViewCell {
    
    let name = UILabel()
    let amount = UIImageView()
    let profit = UILabel()
    
    
    var result: CalculatorResult? {
        didSet {
            configure()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        styleView()
        layoutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func styleView() {
        name.translatesAutoresizingMaskIntoConstraints = false
        amount.translatesAutoresizingMaskIntoConstraints = false
        profit.translatesAutoresizingMaskIntoConstraints = false
        
        amount.contentMode = .scaleAspectFit
        
    }
    
    private func layoutView() {
        contentView.addSubview(name)
        contentView.addSubview(amount)
        contentView.addSubview(profit)
        
        
        NSLayoutConstraint.activate([
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            name.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            profit.leadingAnchor.constraint(equalTo: name.trailingAnchor, constant: 4),
            profit.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            amount.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            amount.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            amount.widthAnchor.constraint(equalToConstant: 30),
            amount.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func configure() {
        guard let result = result else {
            return
        }
        let viewModel = CalculatorResultCellVM(result: result)
        
        name.text = result.name
        profit.text = "\(result.profit) x \(result.amount) = \(viewModel.getTotalProfit())"
        amount.image = UIImage(systemName: "\(result.amount).square")
    }
}
