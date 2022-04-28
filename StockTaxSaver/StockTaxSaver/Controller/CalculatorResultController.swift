//
//  CalculatorResultController.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/04/07.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class CalculatorResultController: UIViewController {
    
    let bag = DisposeBag()
    
    var viewModel: CalculatorResultViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            let cellVMs = viewModel.getResults()
            resultData = cellVMs
        }
    }
    var tot = 0
    
    var resultData = [CalculatorResultCellVM]()
    
    let logoImage = UIImageView(image: UIImage(named: "logo"))
    let tableView = UITableView()
    let totalLab = UILabel()
    let remainingLab = UILabel()
    let reuseIdentifier = "CalculatorResultCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        bind()
        
    }
    
    private func style() {
        view.backgroundColor = .white
        
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        totalLab.translatesAutoresizingMaskIntoConstraints = false
        remainingLab.translatesAutoresizingMaskIntoConstraints = false
        
        logoImage.contentMode = .scaleAspectFit
        
        configureTableView()
    }
    
    private func layout() {
        view.addSubview(logoImage)
        view.addSubview(tableView)
        view.addSubview(totalLab)
        view.addSubview(remainingLab)
        
        NSLayoutConstraint.activate([
            
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logoImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 50),
            logoImage.widthAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: totalLab.topAnchor, constant: -8),
            
            totalLab.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            totalLab.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            remainingLab.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            remainingLab.bottomAnchor.constraint(equalTo: totalLab.bottomAnchor)
        ])
    }
    
    private func configureTableView() {
        tableView.register(CalculatorResultCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 150
    }
    
    private func bind() {
        for cellVm in resultData {
            cellVm.profitSubject
                .observe(on: MainScheduler.instance)
                .subscribe(onNext: {
                    profit in
                    let diff = profit[1] - profit[0]
                    self.tot += diff
                    self.totalLab.text = "\(self.tot)"
                    self.remainingLab.text = "\(totalExempt - self.tot)"
                }).disposed(by: bag)
        }
    }
}


extension CalculatorResultController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        resultData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! CalculatorResultCell
        cell.viewModel = resultData[indexPath.row]
        return cell
    }
    
}
