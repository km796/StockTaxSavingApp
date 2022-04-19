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
    let profitDesc = UILabel()
    let profit = UILabel()
    let total = UILabel()
    
    
    var viewModel: CalculatorResultCellVM? {
        didSet {
            configure()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        styleView()
        layoutView()
        configurePicker()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func styleView() {
        name.translatesAutoresizingMaskIntoConstraints = false
        amount.translatesAutoresizingMaskIntoConstraints = false
        profit.translatesAutoresizingMaskIntoConstraints = false
        total.translatesAutoresizingMaskIntoConstraints = false
        
        amount.contentMode = .scaleAspectFit
        
        name.font = .systemFont(ofSize: 20)
    }
    
    private func layoutView() {
        contentView.addSubview(name)
        contentView.addSubview(amount)
        contentView.addSubview(profit)
        contentView.addSubview(total)
        
        
        NSLayoutConstraint.activate([
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            profit.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 16),
            profit.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            amount.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            amount.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            amount.widthAnchor.constraint(equalToConstant: 30),
            amount.heightAnchor.constraint(equalToConstant: 30),
            
            total.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            total.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        ])
    }
    
    private func configure() {
        guard let viewModel = viewModel else {
            return
        }
        
        name.text = viewModel.result.name
        profit.text = "\(viewModel.result.profit)"
        amount.image = UIImage(systemName: "\(viewModel.result.amount).square")
        
        total.text = "\(viewModel.getTotalProfit())"
    }
    
    private func configurePicker() {
        
    }
}
