//
//  AppDelegate.swift
//  MarsTimes
//
//  Created by Arlindo on 8/28/20.
//  Copyright © 2020 DevByArlindo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setup()
        return true
    }

    func setup() {
        configureTheme()

        window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = UINavigationController(rootViewController: FeedViewController())
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }

    private func configureTheme() {
        let standard = UINavigationBarAppearance()
        let button = UIBarButtonItemAppearance(style: .done)
        button.normal.titleTextAttributes = [.foregroundColor: UIColor.black]
        standard.buttonAppearance = button

        let done = UIBarButtonItemAppearance(style: .done)
        done.normal.titleTextAttributes = [.foregroundColor: UIColor.black]
        standard.doneButtonAppearance = done

        UINavigationBar.appearance().tintColor = UIColor.black
        UINavigationBar.appearance().standardAppearance = standard
    }
}
