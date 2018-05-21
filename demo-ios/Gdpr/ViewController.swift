//
//  ViewController.swift
//  Gdpr
//
//  Created by Cristian Baluta on 21/05/2018.
//  Copyright © 2018 Cristian Baluta. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    fileprivate let gdpr = ConsentKit()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        gdpr.resetAll() // For testing purposes we reset all values from previous run
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if gdpr.needsReviewing(Services.allValues) {
            
            let gdprView = ConsentKitViewController()
            gdprView.items = Services.allValues
            gdprView.defaultValues = [gdpr.isAccepted(Services.icloud), gdpr.isAccepted(Services.analytics)]
            self.present(gdprView, animated: true)
        } else {
            print("All gdpr items already reviewed")
        }
    }
}
