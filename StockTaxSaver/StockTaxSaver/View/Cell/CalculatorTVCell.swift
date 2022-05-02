//
//  CalculatorTVCell.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/04/01.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class CalculatorTVCell: UITableViewCell {
    
    let disposeBag = DisposeBag()
    let nameTf = TfWithLabelOnTop(title: "주식이름", placeholder: "주식이름")
    let currentPriceTf = TfWithLabelOnTop(title: "현재단가", placeholder: "현재단가")
    let purchasePriceTf = TfWithLabelOnTop(title: "매입단가", placeholder: "매입단가")
    let deleteButton = UIButton()
    
    var viewModel: CalculatorElementViewModel? {
        didSet {
            configure()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        styleView()
        layoutView()
        setUpBinding()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func styleView() {
        backgroundColor = .white
        nameTf.translatesAutoresizingMaskIntoConstraints = false
        
        currentPriceTf.translatesAutoresizingMaskIntoConstraints = false
        purchasePriceTf.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
        
        deleteButton.setImage(UIImage(systemName: "trash"), for: .normal)
        deleteButton.tintColor = .gray
    }
    
    private func layoutView() {
        contentView.addSubview(nameTf)
        contentView.addSubview(purchasePriceTf)
        contentView.addSubview(currentPriceTf)
        contentView.addSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            nameTf.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            nameTf.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameTf.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25),
            nameTf.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4),
            
            purchasePriceTf.leadingAnchor.constraint(equalTo: nameTf.trailingAnchor, constant: 16),
            purchasePriceTf.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            purchasePriceTf.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25),
            purchasePriceTf.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4),
            
            currentPriceTf.leadingAnchor.constraint(equalTo: purchasePriceTf.trailingAnchor, constant: 16),
            currentPriceTf.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            currentPriceTf.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25),
            currentPriceTf.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.4),
            
            deleteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
        ])
    }
    
    private func setUpBinding() {
        
        nameTf.tf.tf.rx.text.orEmpty
            .asDriver()
            .drive(onNext: {
                txt in
                self.viewModel?.calculatorElement.name = txt
            }).disposed(by: disposeBag)
        
        purchasePriceTf.tf.tf.rx.text.orEmpty
            .asDriver()
            .drive(onNext: {
                txt in
                self.viewModel?.setPurchasePrice(price: txt)
            }).disposed(by: disposeBag)
        
        currentPriceTf.tf.tf.rx.text.orEmpty
            .asDriver()
            .drive(onNext: {
                txt in
                self.viewModel?.setCurrentPrice(price: txt)
            }).disposed(by: disposeBag)
        
        deleteButton.rx.tap.asDriver()
            .drive(onNext: {
                self.viewModel?.setDeleteClicked()
            }).disposed(by: disposeBag)
    }
    
    private func configure() {
        guard let vm = viewModel else {
            return
        }
        
        if let name = vm.calculatorElement.name {
            nameTf.tf.tf.text = name
        } else {
            nameTf.tf.tf.text = ""
        }
        
        if let purchasePrice = vm.calculatorElement.purchasePrice {
            purchasePriceTf.tf.tf.text = "\(purchasePrice)"
        } else {
            purchasePriceTf.tf.tf.text = ""
        }
        
        if let currentPrice = vm.calculatorElement.currentPrice {
            currentPriceTf.tf.tf.text = "\(currentPrice)"
        } else {
            currentPriceTf.tf.tf.text = ""
        }
    }
}
