//
//  CalculatorController.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/03/03.
//

import UIKit
import RxSwift
import RxCocoa

class CalculatorController: UIViewController {
    
    private let reuseIdentifier = "CalculatorTVCell"
    private let tableView = UITableView()
    private let calculateButton = UILabel()
    
    private var calculatorData = [CalculatorElementViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
    }
    
    
    private func style() {
        view.backgroundColor = .white
        configureTableView()
        configureNavigationBar(withTitle: "Calculator", prefersLargeTitles: false)
        
        calculateButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        calculateButton.text = "Submit"
    }
    
    private func layout() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        navigationItem.rightBarButtonItem = addButton
        
        view.addSubview(tableView)
        view.addSubview(calculateButton)
        
        NSLayoutConstraint.activate([
            calculateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            calculateButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),

            calculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: calculateButton.topAnchor, constant: -8)
        ])
    }
    
    private func configureTableView(){
        let calculatorElement = CalculatorElement(name: "")
        let calculatorElementVM = CalculatorElementViewModel(calculatorElement: calculatorElement)
        calculatorData.append(calculatorElementVM)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CalculatorTVCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 100
    }
    
    
    @objc private func add() {
        let calculatorElement = CalculatorElement(name: "")
        let calculatorElementVM = CalculatorElementViewModel(calculatorElement: calculatorElement)
        calculatorData.append(calculatorElementVM)
        tableView.reloadData()
    }
}


extension CalculatorController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        calculatorData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! CalculatorTVCell
        cell.viewModel = calculatorData[indexPath.row]
        return cell
    }
    
    
}
