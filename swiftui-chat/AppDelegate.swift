//
//  AppDelegate.swift
//  swiftui-chat
//
//  Created by Taisei Shinoda on 2022/08/22.
//

import Foundation
import UIKit
import FirebaseCore


class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions:
                   [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()

    return true
  }
}
