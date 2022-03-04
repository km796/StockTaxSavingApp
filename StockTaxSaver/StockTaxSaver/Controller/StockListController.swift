//
//  StockListController.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/03/03.
//

import Foundation
import UIKit

class StockListController: UIViewController {
    
    let searchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBar()
        setUpViews()
    }
    
    private func setUpViews() {
        
        view.addSubview(searchBar)
    }

}
