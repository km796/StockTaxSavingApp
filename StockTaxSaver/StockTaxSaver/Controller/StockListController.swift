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
    
    var stockPricesList = [StockPriceWithDetails]()
    
    let tableView = UITableView()
    private var editBarButton: UIBarButtonItem!
    
    let viewModel = StockListViewModel()
    
    let reuseIdentifier = "StockListCell"
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBar()
        style()
        layout()
        bind()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getStockPriceList()
    }
    
    private func style() {
        view.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        configureNavigationBar(withTitle: "Stock List", prefersLargeTitles: true)
        configureTableView()
    }
    private func layout() {
        editBarButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
        navigationItem.rightBarButtonItems = [editBarButton]
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func bind() {
        bindNavigationBar()
        viewModel.stockPrices
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {
                spList in
                self.stockPricesList = spList
                self.tableView.reloadData()
            }).disposed(by: disposeBag)
    }
    
    private func configureTableView() {
        tableView.rowHeight = 100
        tableView.register(StockListCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }

    private func bindNavigationBar() {
        editBarButton.rx.tap.asDriver()
            .map { [unowned self] in self.tableView.isEditing }
            .drive(onNext: { [unowned self] result in self.tableView.setEditing(!result, animated: true) })
            .disposed(by: disposeBag)
    }


}

extension StockListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockPricesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! StockListCell
        cell.stockPrice = stockPricesList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        stockPricesList.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        viewModel.reorderSymbols(source: sourceIndexPath.row, destination: destinationIndexPath.row)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            stockPricesList.remove(at: indexPath.row)
            viewModel.removeSymbols(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
