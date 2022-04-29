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
    let titleLab = UILabel()
    let tableView = UITableView()
    let totalLab = UILabel()
    let remainingLab = UILabel()
    let totalDesc = UILabel()
    let remainingDesc = UILabel()
    
    
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
        titleLab.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        totalLab.translatesAutoresizingMaskIntoConstraints = false
        remainingLab.translatesAutoresizingMaskIntoConstraints = false
        totalDesc.translatesAutoresizingMaskIntoConstraints = false
        remainingDesc.translatesAutoresizingMaskIntoConstraints = false
        
        logoImage.contentMode = .scaleAspectFit
        titleLab.text = "계산 결과"
        totalDesc.text = "총 차익"
        remainingDesc.text = "남은 공제액"
        
        totalDesc.font = UIFont.systemFont(ofSize: 14)
        remainingDesc.font = UIFont.systemFont(ofSize: 14)
        
        totalDesc.textColor = .gray
        remainingDesc.textColor = .gray
        
        configureTableView()
    }
    
    private func layout() {
        view.addSubview(logoImage)
        view.addSubview(titleLab)
        view.addSubview(tableView)
        view.addSubview(totalLab)
        view.addSubview(remainingLab)
        view.addSubview(totalDesc)
        view.addSubview(remainingDesc)
        
        NSLayoutConstraint.activate([
            
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logoImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 50),
            logoImage.widthAnchor.constraint(equalToConstant: 50),
            
            titleLab.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleLab.bottomAnchor.constraint(equalTo: logoImage.bottomAnchor),
            titleLab.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: totalDesc.topAnchor, constant: -8),
            
            totalLab.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            totalLab.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            totalDesc.bottomAnchor.constraint(equalTo: totalLab.topAnchor),
            totalDesc.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -80),
            
            remainingLab.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            remainingLab.bottomAnchor.constraint(equalTo: totalLab.bottomAnchor),
            
            remainingDesc.bottomAnchor.constraint(equalTo: remainingLab.topAnchor),
            remainingDesc.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8)
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
                    self.totalLab.text = self.tot.format()
                    self.remainingLab.text = (totalExempt - self.tot).format()
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
        cell.selectionStyle = .none
        return cell
    }
    
}
