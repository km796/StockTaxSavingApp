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
    var left = 0
    var right = 0
    var height = 1
    
    init(type: TfWithPaddingType) {
        super.init(frame: .zero)
        switch(type) {
        case .ordinary:
            styleViewOrdinary()
            layoutViewOrdinary()
        case .center:
            styleViewCenter()
            layoutViewCenter()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func styleViewOrdinary() {
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont.systemFont(ofSize: 10)
    }
    
    private func styleViewCenter() {
        backgroundColor = #colorLiteral(red: 0.9630888104, green: 0.9630888104, blue: 0.9630888104, alpha: 1)
        layer.cornerRadius = 5
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.font = UIFont.boldSystemFont(ofSize: 12)
        tf.textAlignment = .center
    }
    
    private func layoutViewOrdinary() {
        addSubview(tf)
        
        NSLayoutConstraint.activate([
            tf.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            tf.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            tf.centerYAnchor.constraint(equalTo: centerYAnchor),
            tf.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7)
        ])
    }
    
    private func layoutViewCenter() {
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

enum TfWithPaddingType {
    case ordinary
    case center
}
