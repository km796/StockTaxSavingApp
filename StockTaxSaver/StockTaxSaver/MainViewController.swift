//
//  MainViewController.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/03/03.
//

import UIKit

class MainViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupTabBar()
    }
    
    private func setupViews() {
        
    }
    
    private func setupTabBar() {
        let stockListController = StockListController()
        let addStockController = AddStockController()
        let calculatorController = CalculatorController()
        
        stockListController.setTabBarImage(imageName: "list.bullet.circle", title: "Stock List")
        addStockController.setTabBarImage(imageName: "magnifyingglass.circle", title: "Search And Add")
        calculatorController.setTabBarImage(imageName: "wand.and.stars.inverse", title: "Calculator")
        
        let tabBarList = [stockListController, addStockController, calculatorController]
        
        viewControllers = tabBarList
        
    }
}
