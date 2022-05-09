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
    
    var searchData = [StockSearchResult]()
    
    let reuseIdentifier = "SearchResultCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setStatusBar()
        setUpViewController()
        style()
        layout()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.searchData.removeAll()
        self.tableView.reloadData()
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
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchResultCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 80
    }
    
    private func bind() {
        searchResultViewModel.searchResult
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {
                results in
                self.searchData = results
                self.tableView.reloadData()
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

extension AddStockController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! SearchResultCell
        cell.viewModel = SearchResultCellVM(searchResult: searchData[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}
    

