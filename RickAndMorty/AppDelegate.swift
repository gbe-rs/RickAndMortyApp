//
//  AppDelegate.swift
//  RickAndMorty
//
//  Created by Gabriel Ribeiro dos Santos on 20/01/21.
//  Copyright © 2021 Gabriel Ribeiro dos Santos. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    //MARK: - Variables
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 234.0/255.0, green: 46.0/255.0, blue: 73.0/255.0, alpha: 0.8)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "homeViewControllerIdentifier") as! HomeViewController
        
        let navController = UINavigationController(rootViewController: viewController)
        
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        return true
    }
    
}

