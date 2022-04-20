//
//  CalculatorResultCell.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/04/07.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class CalculatorResultCell: UITableViewCell {
    
    let bag = DisposeBag()
    
    let name = UILabel()
    let amount = UIImageView()
    let profitDesc = UILabel()
    let profit = UILabel()
    let total = UILabel()
    let upButton = UIButton()
    let downButton = UIButton()
    
    
    var viewModel: CalculatorResultCellVM? {
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
        total.translatesAutoresizingMaskIntoConstraints = false
        upButton.translatesAutoresizingMaskIntoConstraints = false
        downButton.translatesAutoresizingMaskIntoConstraints = false
        
        amount.contentMode = .scaleAspectFit
        
        name.font = .systemFont(ofSize: 20)
        
        upButton.setImage(UIImage(systemName: "arrowtriangle.up.square"), for: .normal)
        downButton.setImage(UIImage(systemName: "arrowtriangle.down.square"), for: .normal)
    }
    
    private func layoutView() {
        contentView.addSubview(name)
        contentView.addSubview(amount)
        contentView.addSubview(profit)
        contentView.addSubview(total)
        contentView.addSubview(upButton)
        contentView.addSubview(downButton)
        
        
        NSLayoutConstraint.activate([
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            profit.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 16),
            profit.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            upButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            upButton.topAnchor.constraint(equalTo: profit.bottomAnchor, constant: 8),
            upButton.widthAnchor.constraint(equalToConstant: 30),
            upButton.heightAnchor.constraint(equalToConstant: 30),
            
            amount.trailingAnchor.constraint(equalTo: upButton.leadingAnchor, constant: -8),
            amount.bottomAnchor.constraint(equalTo: upButton.bottomAnchor),
            amount.widthAnchor.constraint(equalToConstant: 30),
            amount.heightAnchor.constraint(equalToConstant: 30),
            
            downButton.trailingAnchor.constraint(equalTo: amount.leadingAnchor, constant: -8),
            downButton.bottomAnchor.constraint(equalTo: amount.bottomAnchor),
            downButton.widthAnchor.constraint(equalToConstant: 30),
            downButton.heightAnchor.constraint(equalToConstant: 30),
            
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
        
        viewModel.amountSubject
            .observe(on: MainScheduler.instance)
            .subscribe(onNext:{
                value in
                self.amount.image = UIImage(systemName: "\(value).square")
                
                self.total.text = "\(viewModel.getTotalProfit(amount: value))"
                
            }).disposed(by: bag)
        
        upButton.rx.tap.asDriver()
            .drive(onNext: {
                do {
                    try viewModel.amountSubject.onNext(viewModel.amountSubject.value() + 1)
                } catch {
                    print("Amount subject error")
                }
            }).disposed(by: bag)
        
        downButton.rx.tap.asDriver()
            .drive(onNext: {
                do {
                    try viewModel.amountSubject.onNext(max(0,viewModel.amountSubject.value() - 1))
                    
                } catch {
                    print("Amount subject error")
                }
            }).disposed(by: bag)
    
    }
    
}
