//
//  SearchResultCell.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/03/04.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class SearchResultCell: UITableViewCell {
    
    let bag = DisposeBag()
    
    var viewModel: SearchResultCellVM? {
        didSet {
            configure()
        }
    }
    
    let name = UILabel()
    let symbol = UILabel()
    let currency = UILabel()
    let stackView = UIStackView()
    let addButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        styleViews()
        layout()
        bindView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func styleViews() {
        name.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        name.lineBreakMode = .byWordWrapping
        name.numberOfLines = 0
        
        stackView.axis = .vertical
        stackView.spacing = 4
        
        symbol.font = UIFont.boldSystemFont(ofSize: 16)
        
        
    }
    
    private func layout() {
        contentView.addSubview(name)
        contentView.addSubview(stackView)
        contentView.addSubview(addButton)
        
        stackView.addArrangedSubview(symbol)
        stackView.addArrangedSubview(currency)
        
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.rightAnchor.constraint(equalTo: addButton.leftAnchor, constant: -8),
            
            name.centerYAnchor.constraint(equalTo: centerYAnchor),
            name.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            name.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            
            addButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            addButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8)
        ])
        
        
    }
    
    private func configure() {
        guard let viewModel = viewModel else {
            return
        }
        
        name.text = viewModel.searchResult.name
        symbol.text = viewModel.searchResult.symbol
        currency.text = viewModel.searchResult.currency
        
        viewModel.buttonChecked
            .drive(onNext: { checked in
                if checked {
                    self.addButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
                } else {
                    self.addButton.setImage(UIImage(systemName: "plus.circle"), for: .normal)
                }
            }).disposed(by: bag)
        

    }
    
    private func bindView() {
        addButton.rx.tap.asDriver()
            .drive(onNext: {
                guard let viewModel = self.viewModel else {
                    return
                }
                viewModel.setButtonChecked(checked: !viewModel.buttonState)
                viewModel.saveOrRemoveSymbol()
//                print("tapped: \(viewModel.searchResult.symbol)")
            }).disposed(by: bag)
    }
}
