//
//  TfWithLabelOnTop.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/04/06.
//

import Foundation
import UIKit

class TfWithLabelOnTop: UIView {
    
    let tf = TfWithPadding()
    let titleLabel = UILabel()
    
    init(title: String, placeholder: String) {
        super.init(frame: .zero)
        
        tf.setPlaceholder(placeholder: placeholder)
        
        styleView(title: title)
        layoutView()
    }
    
    private func styleView(title: String) {
        tf.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        titleLabel.text = title
        titleLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func layoutView() {
        addSubview(tf)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            tf.leadingAnchor.constraint(equalTo: leadingAnchor),
            tf.trailingAnchor.constraint(equalTo: trailingAnchor),
            tf.bottomAnchor.constraint(equalTo: bottomAnchor),
            tf.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
            
            titleLabel.bottomAnchor.constraint(equalTo: tf.topAnchor, constant: -2),
            titleLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
