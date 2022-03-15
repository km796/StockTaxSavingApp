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
        
        let nav1 = UINavigationController(rootViewController: stockListController)
        let nav2 = UINavigationController(rootViewController: addStockController)
        let nav3 = UINavigationController(rootViewController: calculatorController)
        
        nav1.setTabBarImage(imageName: "list.bullet.circle", title: "Stock List")
        nav2.setTabBarImage(imageName: "magnifyingglass.circle", title: "Search And Add")
        nav3.setTabBarImage(imageName: "wand.and.stars.inverse", title: "Calculator")
        
        let tabBarList = [nav1, nav2, nav3]
        
        viewControllers = tabBarList
        
    }
}
