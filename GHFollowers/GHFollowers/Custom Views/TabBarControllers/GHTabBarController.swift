//
//  GHTabBarController.swift
//  GHFollowers
//
//  Created by Abdelrahman Sobhy on 7/29/21.
//

import UIKit

class GHTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchNC(), createFavouriteNC()]
    }
    
    func createSearchNC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    func createFavouriteNC() -> UINavigationController {
        let favouriteLastVC = FavouriteLastVC()
        favouriteLastVC.title = "Favourite"
        favouriteLastVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favouriteLastVC)
    }

}
