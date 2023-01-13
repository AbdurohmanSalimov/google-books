//
//  HomeTabBar.swift
//  google books
//
//  Created by Azizbek Salimov on 09/01/23.
//

import UIKit

class MainTabbar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabbar()
    }
    
    func setupTabbar() {
        
        // setup TabBar
        
       
       
//
        let appereance = UITabBarAppearance()
        appereance.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.6705882353, blue: 0, alpha: 1)
        
        
        let appereance2 = UITabBarItemAppearance()
        appereance2.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
//        self.tabBar.standardAppearance = appereance
        
        self.tabBar.barStyle = .default
        self.tabBar.tintColor = .black
        self.tabBar.unselectedItemTintColor = #colorLiteral(red: 0.9469916888, green: 0.9469916888, blue: 0.9469916888, alpha: 1)
        self.tabBar.isTranslucent = true
        self.tabBar.standardAppearance = appereance
        self.tabBar.scrollEdgeAppearance = appereance
        self.tabBar.barTintColor = .none
        
        
        //Setup Items of TabBar
        let vc1 = UINavigationController(rootViewController: HomeViewController() )
        vc1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        vc1.tabBarItem.title = "Home"
        
        let vc2 = UINavigationController(rootViewController: FavoritesViewController() )
        vc2.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "heart"), selectedImage: UIImage(systemName: "heart.fill"))
        
        
        viewControllers = [vc1,vc2]
        
    }
    
}
