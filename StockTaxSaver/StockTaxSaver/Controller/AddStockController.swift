//
//  AddStockController.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/03/03.
//

import UIKit
import RxSwift
import RxCocoa

class AddStockController: UIViewController {
    
    //dispose bag
    let disposeBag = DisposeBag()
    
    //view elements
    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    //view model
    let searchResultViewModel = SearchResultViewModel()
    
    let reuseIdentifier = "SearchResultCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStatusBar()
        setUpViewController()
        style()
        layout()
        bind()
    }
    
    private func setUpViewController() {
        searchBar.delegate = self
    }
    
    
    private func style(){
        configureNavigationBar(withTitle: "Add Your Stocks", prefersLargeTitles: false)
        view.backgroundColor = .white
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.register(SearchResultCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 80
    }
    
    private func bind() {
        searchResultViewModel.searchResult
            .bind(to: tableView.rx.items(cellIdentifier: reuseIdentifier, cellType: SearchResultCell.self)){
                index, model, cell in
                cell.searchResult = model
            }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(SearchResult.self)
            .subscribe(onNext: { [weak self] searchResult in
                SaveService.shared.addToList(symbol: searchResult.symbol)
                SaveService.shared.addDescription(for: searchResult.symbol, description: searchResult.description)
                self?.tabBarController?.selectedIndex = 0
            }).disposed(by: disposeBag)
    }

}

//MARK: UISearchBarDelegate
extension AddStockController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, text.count != 0 else {
            return
        }
        searchResultViewModel.getSearchResult(stockName: text)
    }
}
    

