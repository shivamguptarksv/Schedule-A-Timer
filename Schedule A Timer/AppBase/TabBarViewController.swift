//
//  TabBarViewController.swift
//  Schedule A Timer
//
//  Created by Saurabh Gupta on 15/07/25.
//

import UIKit

class TabBarViewController: UITabBarController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViewController()
  }
  
  func setupViewController() {
    
    let vc1 = MainViewController()
    vc1.tabBarItem.title = "Custom Timer"
    vc1.tabBarItem.image = UIImage(systemName: "clock")
    
    
    let vc2 = CustomTimerViewController()
    vc2.tabBarItem.title = "System Timer"
    vc2.tabBarItem.image = UIImage(systemName: "square.and.arrow.up")
    
    let vc3 = SystemTimerViewController()
    vc3.tabBarItem.title = " Advance Timer"
    vc3.tabBarItem.image = UIImage(systemName: "square.and.arrow.down")
    
    let nav1 = UINavigationController(rootViewController:vc1)
    let nav2 = UINavigationController(rootViewController: vc2)
    let nav3 = UINavigationController(rootViewController: vc3)
    
    tabBar.tintColor = .label
    setViewControllers([nav1, nav2, nav3], animated: true)
  }
  
}
