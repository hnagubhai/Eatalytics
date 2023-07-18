//
//  Eatalytics2App.swift
//  Eatalytics2
//
//  Created by Hemanth Nagubhai on 7/3/23.
//
// 7/17/23 // Merging back into Main

import SwiftUI
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct Eatalytics2App: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate


  var body: some Scene {
    WindowGroup {
      NavigationView {
        ViewHandler()
      }
      .environmentObject(AuthViewModel())
    }
  }
}
