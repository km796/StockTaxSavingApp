//
//  TfWithPadding.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/04/06.
//

import Foundation
import UIKit

class TfWithPadding: UIView {
    
    let tf = UITextField()
    
    init() {
        super.init(frame: .zero)
        styleView()
        layoutView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func styleView() {
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont.systemFont(ofSize: 10)
    }
    
    private func layoutView() {
        addSubview(tf)
        
        
        NSLayoutConstraint.activate([
            tf.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            tf.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            tf.centerYAnchor.constraint(equalTo: centerYAnchor),
            tf.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7)
        ])
    }
    
    func setPlaceholder(placeholder: String) {
        tf.placeholder = placeholder
    }
}
