//
//  ViewController.swift
//  Gdpr
//
//  Created by Cristian Baluta on 21/05/2018.
//  Copyright © 2018 Cristian Baluta. All rights reserved.
//

import UIKit

class ViewController: UITabBarController {

    fileprivate let gdpr = ConsentKit()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gdpr.resetAll() // For testing purposes we reset all values from previous run
    }
}
