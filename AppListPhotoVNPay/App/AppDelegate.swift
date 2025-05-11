//
//  AppDelegate.swift
//  AppListPhotoVNPay
//
//  Created by Trịnh Xuân Minh on 11/5/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let window = UIWindow(frame: UIScreen.main.bounds)
    let coordinator = PhotoListCoordinator(window: window)
    coordinator.start()
    self.window = window
    return true
  }
}
