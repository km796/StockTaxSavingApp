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
import RxDataSources

class StockListController: UIViewController {
    
    typealias StockDetailsSectionModel = AnimatableSectionModel<String, StockPriceWithDetails>
    
    var dataSource: RxTableViewSectionedAnimatedDataSource<StockDetailsSectionModel>!
    
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
            .map { [StockDetailsSectionModel(model:"", items: $0)]}
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func configureTableView() {
        tableView.rowHeight = 100
        tableView.register(StockListCell.self, forCellReuseIdentifier: reuseIdentifier)
        setUpDataSource()
        
        
    }
    
    private func setUpDataSource() {
        dataSource = RxTableViewSectionedAnimatedDataSource<StockDetailsSectionModel>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .right, reloadAnimation: .bottom, deleteAnimation: .left),
            configureCell: configureCell,
            canEditRowAtIndexPath: canEditRowAtIndexPath,
            canMoveRowAtIndexPath: canMoveRowAtIndexPath
        )
    }

    private func bindNavigationBar() {
        editBarButton.rx.tap.asDriver()
            .map { [unowned self] in self.tableView.isEditing }
            .drive(onNext: { [unowned self] result in self.tableView.setEditing(!result, animated: true) })
            .disposed(by: disposeBag)
    }


}

extension StockListController {
    private var configureCell: RxTableViewSectionedAnimatedDataSource<StockDetailsSectionModel>.ConfigureCell {
        return { _, tableView, indexPath, model in
            var cell: StockListCell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath) as! StockListCell
            cell.stockPrice = model
            return cell
        }
    }
    
    private var canEditRowAtIndexPath: RxTableViewSectionedAnimatedDataSource<StockDetailsSectionModel>.CanEditRowAtIndexPath {
        return { [unowned self] _, _ in
            if self.tableView.isEditing {
                return true
            } else {
                return false
            }
        }
    }
    
    private var canMoveRowAtIndexPath: RxTableViewSectionedAnimatedDataSource<StockDetailsSectionModel>.CanMoveRowAtIndexPath {
        return { _, _ in
            return true
        }
    }
}
