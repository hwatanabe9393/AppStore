//
//  BaseTabBarController.swift
//  AppStore
//
//  Created by Hikaru Watanabe on 3/20/19.
//  Copyright © 2019 Hikaru Watanabe. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [
            createNavController(rootViewController: TodayController(), title: "Today", imageName: "today"),
            createNavController(rootViewController: AppsController(), title: "Apps", imageName: "apps"),
            createNavController(rootViewController: AppsSearchController(), title: "Search", imageName: "search")
        ]
    }
    
    ///Return UINavigationController with provided arguments.
    fileprivate func createNavController(rootViewController: UIViewController, title: String, imageName: String)->UINavigationController{
        rootViewController.navigationItem.title = title
        rootViewController.view.backgroundColor = .white
        
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        navController.navigationBar.prefersLargeTitles = true
        return navController
    }
}
