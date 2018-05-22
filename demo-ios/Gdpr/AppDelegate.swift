//
//  AppDelegate.swift
//  Gdpr
//
//  Created by Cristian Baluta on 21/05/2018.
//  Copyright © 2018 Cristian Baluta. All rights reserved.
//

import UIKit

enum Services: String, ConsentKitItem {

    case icloud = "iCloud"
    case analytics = "analytics"

    func title() -> String {
        switch self {
        case .icloud: return "iCloud"
        case .analytics: return "Google analytics"
        }
    }

    func description() -> String {
        switch self {
        case .icloud: return "Store data to the Apple's iCloud. This will allow the data to by synced across all your devices."
        case .analytics: return "Help developer understand how the app is used by sharing usage with Google analytics."
        }
    }

    func alertMessage() -> String {
        switch self {
        case .icloud: return "I accept that this app will store my data in the Apple's iCloud for the purpose of syncing it across multiple devices and backup!"
        case .analytics: return "I accept that this app will store usage data in Google analytics for the purpose of improving the app!"
        }
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
}

