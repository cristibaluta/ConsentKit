//
//  SimpleViewController.swift
//  Gdpr
//
//  Created by Cristian Baluta on 22/05/2018.
//  Copyright © 2018 Imagin soft. All rights reserved.
//

import UIKit

class SimpleViewController: UIViewController {
    
    fileprivate let gdpr = ConsentKit()
    
    @IBOutlet var label: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if gdpr.needsReviewing([Services.icloud, Services.analytics]) {
            label.text = "Gdpr needs reviewing!"
        } else {
            label.text = "All gdpr items already reviewed"
        }
    }
    
    @IBAction func handleGdpr() {
        
        let gdprView = ConsentKitViewController()
        gdprView.items = [
            (Services.icloud, gdpr.isAccepted(Services.icloud)),
            (Services.analytics, gdpr.isAccepted(Services.analytics))
        ]
        self.present(gdprView, animated: true)
    }
}
