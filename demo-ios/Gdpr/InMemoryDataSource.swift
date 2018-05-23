//
//  InMemorydataSource.swift
//  Gdpr
//
//  Created by Cristian Baluta on 23/05/2018.
//  Copyright © 2018 Imagin soft. All rights reserved.
//

import Foundation

class InMemoryDataSource: ConsentKitDataSource {
    
    private var dict = [String: Bool?]()
    
    func isAccepted (_ item: ConsentKitItem) -> Bool {
        return dict[item.rawValue] == true
    }
    
    func isReviewed (_ item: ConsentKitItem) -> Bool {
        return dict[item.rawValue] != nil
    }
    
    func setAccepted (_ value: Bool, for item: ConsentKitItem) {
        dict[item.rawValue] = value
    }
}
