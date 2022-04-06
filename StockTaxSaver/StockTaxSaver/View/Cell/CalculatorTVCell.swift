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
    let nameTf = TfWithLabelOnTop(title: "name", placeholder: "name")
    let priceTf = UITextField()
    
    var viewModel: CalculatorElementViewModel? {
        didSet {
            guard let vm = viewModel else {
                return
            }
            nameTf.tf.tf.text = vm.calculatorElement.name
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
        
        priceTf.translatesAutoresizingMaskIntoConstraints = false
        priceTf.placeholder = "price"
        
        layer.cornerRadius = 10
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
        
    }
    
    private func layoutView() {
        contentView.addSubview(nameTf)
        
        NSLayoutConstraint.activate([
            nameTf.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameTf.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameTf.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            nameTf.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3)
        ])
    }
    
    private func setUpBinding() {
        nameTf.tf.tf.rx.text.orEmpty
            .asDriver()
            .drive(onNext: {
                txt in
                self.viewModel?.calculatorElement.name = txt + "$"
            }).disposed(by: disposeBag)
    }
}
