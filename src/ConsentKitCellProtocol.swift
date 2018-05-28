//
//  ConsentKitCellProtocol.swift
//
//  Created by Cristian Baluta on 28/05/2018.
//  Copyright © 2018 Imagin soft. All rights reserved.
//

import Foundation

protocol ConsentKitCellProtocol {
    var title: String {get set}
    var subtitle: String {get set}
    var value: Bool {get set}
    var valueDidChange: ((Bool) -> Void)? {get set}
}
