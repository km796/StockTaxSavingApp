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
    private let calculateButton = ButtonWithLogo()
    
    private var calculatorData = [CalculatorElementViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        keyboardControl()
    }
    
    private func style() {
        view.backgroundColor = #colorLiteral(red: 0.9662850936, green: 0.9758522727, blue: 0.9758522727, alpha: 1)
        configureTableView()
        configureNavigationBar(withTitle: "Calculator", prefersLargeTitles: false)
        
        calculateButton.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        calculateButton.setText(text: "계산하기")
        calculateButton.addTarget(self, action: #selector(moveToResult), for: .touchUpInside)
    }
    
    private func layout() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(add))
        navigationItem.rightBarButtonItem = addButton
        
        view.addSubview(tableView)
        view.addSubview(calculateButton)
        
        NSLayoutConstraint.activate([
            calculateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            calculateButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            calculateButton.heightAnchor.constraint(equalToConstant: 40),
            calculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo: calculateButton.topAnchor, constant: -8)
        ])
    }
    
    private func configureTableView(){
        let calculatorElement = CalculatorElement()
        let calculatorElementVM = CalculatorElementViewModel(calculatorElement: calculatorElement)
        calculatorData.append(calculatorElementVM)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CalculatorTVCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 100
        tableView.backgroundColor = UIColor.clear
        tableView.keyboardDismissMode = .onDrag
    }
    
    private func keyboardControl() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func add() {
        let calculatorElement = CalculatorElement()
        let calculatorElementVM = CalculatorElementViewModel(calculatorElement: calculatorElement)
        calculatorData.append(calculatorElementVM)
        tableView.reloadData()
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        tableView.contentInset = .zero
    }
    
    @objc private func moveToResult() {
        let resultController = CalculatorResultController()
        let elements = calculatorData.map({
            vm in
            return vm.calculatorElement
        })
        let resultVM  = CalculatorResultViewModel(elements: elements)
        resultController.viewModel = resultVM
        self.present(resultController, animated: true, completion: nil)
    }
    
}


extension CalculatorController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return calculatorData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! CalculatorTVCell
        cell.viewModel = calculatorData[indexPath.section]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}
