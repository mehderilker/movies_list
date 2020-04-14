//
//  AppDelegate.swift
//  Movies
//
//  Created by ilker on 8.04.2020.
//  Copyright © 2020 ilker. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.configureInitialWindow()
        return true
    }
    
    private func configureInitialWindow() {
        self.window =  UIWindow()
        
        let entranceVC = ArenaType.homePage
        entranceVC.launch()
    }
    
}

