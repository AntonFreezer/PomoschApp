//
//  TabBarController.swift
//  PomoschApp
//
//  Created by Anton Kholodkov on 18.01.2024.
//

import UIKit

final class TabBarController: UITabBarController {
    
    //MARK: Navigation Appearance
    
    private class navController: UINavigationController {
        override var childForStatusBarStyle: UIViewController? {
            visibleViewController
        }
    }
    
    //MARK: Lifecycle & Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
    }
    
    func setUpTabs() {
        let wardsListVC = WardsListVC()
        let manifestVC = ManifestVC()
        
        wardsListVC.navigationItem.largeTitleDisplayMode = .automatic
        manifestVC.navigationItem.largeTitleDisplayMode = .automatic
        
        let nav1 = navController(rootViewController: wardsListVC)
        let nav2 = navController(rootViewController: manifestVC)
        
        let nav1ImageConfiguration = UIImage.SymbolConfiguration(hierarchicalColor: .darkGray)
        let nav1Image = UIImage(systemName: "person.3.sequence", withConfiguration: nav1ImageConfiguration)
        nav1.tabBarItem = UITabBarItem(title: "Wards", image: nav1Image, tag: 1)
        
        let nav2ImageConfiguration = UIImage.SymbolConfiguration(hierarchicalColor: .darkGray)
        let nav2Image = UIImage(systemName: "info.circle", withConfiguration: nav2ImageConfiguration)
        nav2.tabBarItem = UITabBarItem(title: "About", image: nav2Image, tag: 2)
        
        nav1.navigationBar.prefersLargeTitles = true
        nav2.navigationBar.prefersLargeTitles = true
        
        setViewControllers([nav1, nav2], animated: true)
        tabBar.barStyle = .default
    }
}


