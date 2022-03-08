//
//  StockListController.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/03/03.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class StockListController: UIViewController {
    
    let tableView = UITableView()
    
    let viewModel = StockListViewModel()
    
    let reuseIdentifier = "StockListCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBar()
        style()
        layout()
        bind()
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
        viewModel.getStockList()
            .bind(to: tableView.rx.items(cellIdentifier: reuseIdentifier, cellType: StockListCell.self)){
                index, model, cell in
                cell.stockInfo = model
            }
    }
    
    private func configureTableView() {
        tableView.rowHeight = 150
        
    }

}
