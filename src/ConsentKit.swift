//
//  ConsentKit.swift
//
//  Created by Cristian Baluta on 21/05/2018.
//  Copyright © 2018 Imagin soft. All rights reserved.
//

import Foundation

protocol ConsentKitItem {
    var rawValue: String {get}
    /// Title used in the cell and alert
    func title() -> String
    /// Description used in the cell
    func description() -> String
    /// Message displayed by the alert when the switch is turned on
    func alertMessage() -> String
}

protocol ConsentKitDataSource {
    /// Returns if the item has a value of true
    func isAccepted (_ item: ConsentKitItem) -> Bool
    /// Returns if the item's value is different than nil, which means it was reviewed
    func isReviewed (_ item: ConsentKitItem) -> Bool
    /// Set a value for the item
    func setAccepted (_ value: Bool, for item: ConsentKitItem)
    /// Resets the value of an item, which means that isReviewed will return false after that
    func reset (_ item: ConsentKitItem)
}

extension ConsentKitDataSource {
    func reset (_ item: ConsentKitItem) {
        // This is a empty implementation to allow this method to be optional
    }
}

class ConsentKit {
    
    /// Assign a custom dataSource. By default UserDefaults is used and each key is prefixed with "ConsentKit-"
    var dataSource: ConsentKitDataSource = ConsentKitUserDefaultsDataSource()
    
    convenience init (dataSource: ConsentKitDataSource) {
        self.init()
        self.dataSource = dataSource
    }
    
    /// Returns if there's any value that was not reviewed
    /// Used to check if the ConsentKitViewController should be presented or not
    /// This will also be useful to present the controller if any new service added later in the app needs reviewing
    func needsReviewing(_ items: [ConsentKitItem]) -> Bool {
        for item in items {
            if !isReviewed(item) {
                return true
            }
        }
        return false
    }
}

extension ConsentKit: ConsentKitDataSource {
    
    func isAccepted (_ item: ConsentKitItem) -> Bool {
        return dataSource.isAccepted(item)
    }

    func isReviewed (_ item: ConsentKitItem) -> Bool {
        return dataSource.isReviewed(item)
    }

    func setAccepted (_ value: Bool, for item: ConsentKitItem) {
        dataSource.setAccepted(value, for: item)
    }
    
    func reset (_ item: ConsentKitItem) {
        dataSource.reset(item)
    }
}
