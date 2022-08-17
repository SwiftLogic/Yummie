//
//  AppDelegate.swift
//  Yummie
//
//  Created by Osaretin Uyigue on 7/13/21.
//

import UIKit
import IQKeyboardManagerSwift
@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        let startingVC = UserDefaults.standard.hasOnboarded ? HomeVC() : OnBoardingVC()
        window?.rootViewController = UINavigationController(rootViewController: startingVC)

        // setup iq keyboard manager
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        return true
    }


}

