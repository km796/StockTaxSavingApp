//
//  CalculatorResultController.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/04/07.
//

import Foundation
import UIKit

class CalculatorResultController: UIViewController {
    
    
    var viewModel: CalculatorResultViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            let cellVMs = viewModel.getResults()
            resultData = cellVMs
        }
    }
    
    var resultData = [CalculatorResultCellVM]()
    
    let tableView = UITableView()
    let reuseIdentifier = "CalculatorResultCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        
    }
    
    private func style() {
        view.backgroundColor = #colorLiteral(red: 0.9662850936, green: 0.9758522727, blue: 0.9758522727, alpha: 1)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        configureTableView()
    }
    
    private func layout() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func configureTableView() {
        tableView.register(CalculatorResultCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 200
    }
}


extension CalculatorResultController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        resultData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! CalculatorResultCell
        cell.viewModel = resultData[indexPath.row]
        return cell
    }
    
}
