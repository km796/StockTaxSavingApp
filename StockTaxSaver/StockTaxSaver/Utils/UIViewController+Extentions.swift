//
//  UIViewController+Extentions.swift
//  StockTaxSaver
//
//  Created by Min Su Kang on 2022/03/03.
//

import UIKit

extension UIViewController {
    func setStatusBar() {
        let barSize = UIApplication.shared.statusBarFrame.size
        let frame = CGRect(origin: .zero, size: barSize)
        let barView = UIView(frame: frame)
        
        barView.backgroundColor = .systemGreen
        view.addSubview(barView)
    }
    
    func setTabBarImage(imageName: String, title: String) {
        let config = UIImage.SymbolConfiguration(scale: .large)
        let image = UIImage(systemName: imageName, withConfiguration: config)
        
        tabBarItem = UITabBarItem(title: title, image: image, tag: 0)
    }
    
    func configureNavigationBar(withTitle title: String, prefersLargeTitles: Bool) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .systemIndigo

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        navigationController?.navigationBar.prefersLargeTitles = prefersLargeTitles
        navigationItem.title = title
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.isTranslucent = true

        navigationController?.navigationBar.overrideUserInterfaceStyle = .dark
    }
    
}
