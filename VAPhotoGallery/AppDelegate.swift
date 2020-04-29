//
//  AppDelegate.swift
//  VAPhotoGallery
//
//  Created by Vikash Anand on 26/04/20.
//  Copyright © 2020 Vikash Anand. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customisation after application launch.
        defer { window?.makeKeyAndVisible() }

        let rootViewController = UIStoryboard.instantiateViewController(ofType: RootViewController.self)
        let rootNavigationController = UINavigationController.init(rootViewController: rootViewController)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootNavigationController
        return true
    }

}

