//
//  NavigationViewController.swift
//  Gdpr
//
//  Created by Cristian Baluta on 23/05/2018.
//  Copyright © 2018 Imagin soft. All rights reserved.
//

import UIKit

class NavigationViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if gdpr.needsReviewing([Services.icloud, Services.analytics, ConsentKitServices.location]) {
            label.text = "Gdpr needs reviewing!"
        } else {
            label.text = "All gdpr items already reviewed"
        }
    }
    
    @IBAction func handleGdpr() {
        
        let vc = ConsentKitViewController()
        vc.items = [Services.icloud, Services.analytics, ConsentKitServices.location]
        vc.didFinishReview = {
            self.navigationController?.popViewController(animated: true)
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
