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
    let nameTf = UITextField()
    let priceTf = UITextField()
    
    var viewModel: CalculatorElementViewModel? {
        didSet {
            guard let vm = viewModel else {
                return
            }
            nameTf.text = vm.calculatorElement.name
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        styleView()
        layoutView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func styleView() {
        nameTf.translatesAutoresizingMaskIntoConstraints = false
        nameTf.placeholder = "name"
        
        priceTf.translatesAutoresizingMaskIntoConstraints = false
        priceTf.placeholder = "price"
        
        nameTf.rx.text.orEmpty
            .asDriver()
            .drive(onNext: {
                txt in
                self.viewModel?.calculatorElement.name = txt + "$"
            }).disposed(by: disposeBag)
    }
    
    private func layoutView() {
        contentView.addSubview(nameTf)
        
        NSLayoutConstraint.activate([
            nameTf.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameTf.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameTf.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5)
        ])
    }
}
