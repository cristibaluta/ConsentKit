//
//  ConsentKitItems.swift
//  Gdpr
//
//  Created by Cristian Baluta on 23/05/2018.
//  Copyright © 2018 Imagin soft. All rights reserved.
//

import Foundation

enum ConsentKitServices: String, ConsentKitItem {
    
    case icloud = "ck-icloud"
    case analytics = "ck-analytics"
    case location = "ck-location"
    
    func title() -> String {
        switch self {
        case .icloud: return "iCloud"
        case .analytics: return "Google analytics"
        case .location: return "Location"
        }
    }
    
    func description() -> String {
        switch self {
        case .icloud: return "Store data to the Apple's iCloud. This will allow the data to by synced across all your devices."
        case .analytics: return "Help developer understand how the app is used by sharing usage with Google analytics."
        case .location: return "Store location on server"
        }
    }
    
    func alertMessage() -> String {
        switch self {
        case .icloud: return "I accept that this app will store my data in the Apple's iCloud for the purpose of syncing it across multiple devices and backup"
        case .analytics: return "I accept that this app will store anonymous usage data in Google analytics for the purpose of improving the app"
        case .location: return "I accept to store my location on the server"
        }
    }
}
