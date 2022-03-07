//
//  StockListController.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/03/03.
//

import Foundation
import UIKit

class StockListController: UIViewController {
    
    let tableView = UITableView()
    
    let viewModel = StockListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBar()
        style()
        layout()
        bind()
        APIService().fetchStockInfo(with: "IBM")
    }
    
    
    private func style() {
        view.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        configureTableView()
    }
    private func layout() {
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func bind() {
        
    }
    
    private func configureTableView() {
        tableView.rowHeight = 150
        
    }

}
