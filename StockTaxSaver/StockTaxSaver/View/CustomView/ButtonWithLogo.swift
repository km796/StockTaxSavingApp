//
//  ButtonWithLogo.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/04/07.
//

import Foundation
import UIKit

class ButtonWithLogo: UIButton {
    
    let logoImage = UIImageView(image: UIImage(named: "logo"))
    let label = UILabel()
    
    init() {
        super.init(frame: .zero)
        styleView()
        layoutView()
    }
    
    private func styleView(){
        backgroundColor = #colorLiteral(red: 0.368627451, green: 0.3607843137, blue: 0.9019607843, alpha: 1)
        layer.cornerRadius = 10
        
        logoImage.contentMode = .scaleAspectFit
        
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = .white
    }
    
    private func layoutView(){
        addSubview(logoImage)
        addSubview(label)
        
        NSLayoutConstraint.activate([
            logoImage.trailingAnchor.constraint(equalTo: label.leadingAnchor),
            logoImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoImage.heightAnchor.constraint(equalTo: heightAnchor),
            logoImage.widthAnchor.constraint(equalTo: heightAnchor),
            
            label.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 8),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setText(text: String) {
        label.text = text
    }
}
