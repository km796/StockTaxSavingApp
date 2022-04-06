//
//  SearchResultCell.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/03/04.
//

import Foundation
import UIKit

class SearchResultCell: UITableViewCell {
    
    var searchResult: StockSearchResult? {
        didSet {
            configure()
        }
    }
    
    let name = UILabel()
    let symbol = UILabel()
    let currency = UILabel()
    let stackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        styleViews()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func styleViews() {
        name.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        name.lineBreakMode = .byWordWrapping
        name.numberOfLines = 0
        
        stackView.axis = .vertical
        stackView.spacing = 4
        
        symbol.font = UIFont.boldSystemFont(ofSize: 16)

        
    }
    
    private func layout() {
        addSubview(name)
        addSubview(stackView)
        
        stackView.addArrangedSubview(symbol)
        stackView.addArrangedSubview(currency)
        
        
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            
            name.centerYAnchor.constraint(equalTo: centerYAnchor),
            name.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            name.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5)
        ])
        
        
    }
    
    private func configure() {
        guard let searchResult = searchResult else {
            return
        }

        name.text = searchResult.name
        symbol.text = searchResult.symbol
    }
}
