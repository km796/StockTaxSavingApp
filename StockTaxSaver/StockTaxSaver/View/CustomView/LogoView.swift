//
//  LogoView.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/03/31.
//

import Foundation
import UIKit

class LogoView: UIView {
    
    let logoImage = UIImageView(image: UIImage(named: "logo"))
    let titleImage = UIImageView(image: UIImage(named: "logoTitle"))
    
    init() {
        super.init(frame: .zero)
        
        addSubview(logoImage)
        addSubview(titleImage)
        
        logoImage.contentMode = .scaleAspectFit
        titleImage.contentMode = .scaleAspectFit
        
        
        
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        titleImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            logoImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            logoImage.topAnchor.constraint(equalTo: topAnchor),
            logoImage.bottomAnchor.constraint(equalTo: bottomAnchor),
            logoImage.widthAnchor.constraint(equalTo: heightAnchor),
            logoImage.heightAnchor.constraint(equalTo: heightAnchor),
            titleImage.leadingAnchor.constraint(equalTo: logoImage.trailingAnchor, constant: 4),
            titleImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3),
            titleImage.topAnchor.constraint(equalTo: topAnchor),
            titleImage.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }


}
