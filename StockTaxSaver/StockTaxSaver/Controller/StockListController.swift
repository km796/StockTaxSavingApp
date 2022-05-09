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
    
    //ViewModel
    let viewModel = StockListViewModel()
    
    //Data
    var stockPricesList = [StockPriceWithDetails]()
    
    //Views
    let tableView = UITableView()
    let emptyListMessage = UILabel()
    private let refreshControl = UIRefreshControl()
    private var editBarButton: UIBarButtonItem!
    private var refreshBarButton: UIBarButtonItem!
    
    //Dispose Bag
    let disposeBag = DisposeBag()
    
    //Reuseidentifier
    let reuseIdentifier = "StockListCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBar()
        addTableViewRefresh()
        style()
        layout()
        bind()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getStockPriceList()
    }
    
    func addTableViewRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    private func style() {
        view.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        emptyListMessage.translatesAutoresizingMaskIntoConstraints = false
        
        emptyListMessage.isHidden = true
        emptyListMessage.text = "리스트가 비었습니다.\n아래 탭에서 검색 후 추가해주세요"
        emptyListMessage.numberOfLines = 0
        emptyListMessage.textAlignment = .center
        emptyListMessage.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        
        
        configureNavigationBar(withTitle: nil, prefersLargeTitles: false)
        configureTableView()
    }
    private func layout() {
        editBarButton = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: nil)
        refreshBarButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        navigationItem.rightBarButtonItems = [editBarButton, refreshBarButton]
        
        view.addSubview(tableView)
        view.addSubview(emptyListMessage)
        
        NSLayoutConstraint.activate([
            emptyListMessage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            emptyListMessage.leftAnchor.constraint(equalTo: view.leftAnchor),
            emptyListMessage.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func bind() {
        bindNavigationBar()
        viewModel.stockPrices
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {
                spList in
                if spList.isEmpty {
                    self.emptyListMessage.isHidden = false
                } else {
                    self.emptyListMessage.isHidden = true
                }
                self.stockPricesList = spList
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
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
    
    @objc private func refresh() {
        viewModel.getStockPriceList()
    }
    

}

//MARK: TableView delegate and data source
extension StockListController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockPricesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! StockListCell
        cell.stockPrice = stockPricesList[indexPath.row]
        cell.selectionStyle = .none
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
