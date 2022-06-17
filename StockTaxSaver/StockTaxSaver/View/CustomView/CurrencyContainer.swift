//
//  CurrencyContainer.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/05/11.
//

import Foundation
import UIKit

class CurrencyContainer: UIView {
    let imageView = UIImageView()
    let titleView = UILabel()
    let currency = UILabel()
    
    init() {
        super.init(frame: .zero)
        styleView()
        layoutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func styleView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleView.translatesAutoresizingMaskIntoConstraints = false
        currency.translatesAutoresizingMaskIntoConstraints = false
        
        titleView.font = .systemFont(ofSize: 12)
        currency.font = .boldSystemFont(ofSize: 16)
        
        titleView.textColor = .gray
        currency.textColor = .darkGray
    }
    
    private func layoutView() {
        addSubview(imageView)
        addSubview(titleView)
        addSubview(currency)
        
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 4),
            imageView.widthAnchor.constraint(equalToConstant: 30),
            imageView.heightAnchor.constraint(equalToConstant: 30),
            
            titleView.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 8),
            titleView.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            currency.centerYAnchor.constraint(equalTo: centerYAnchor),
            currency.leftAnchor.constraint(equalTo: titleView.rightAnchor, constant: 8)
        ])
        
    }
    
    func setImage(image: UIImage?) {
        self.imageView.image = image
    }
    
    func setTitle(title: String) {
        self.titleView.text = title
    }
    
    func setPrice(price: Double) {
        self.currency.text = "\(price.rounded(toPlaces: 2)) 원"
    }
}
