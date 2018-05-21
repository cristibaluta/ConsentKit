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

    func alertDescription() -> String {
        switch self {
        case .icloud: return "I hereby accept this app to store my data in the Apple's iCloud!"
        case .analytics: return "I hereby accept this app to store analytics in Google analytics!"
        }
    }

    static var allValues: [ConsentKitItem] = [Services.icloud, Services.analytics]
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
}

