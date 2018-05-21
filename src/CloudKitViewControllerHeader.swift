//
//  CloudKitViewControllerHeader.swift
//  ConsentIos
//
//  Created by Cristian Baluta on 21/05/2018.
//  Copyright © 2018 Cristian Baluta. All rights reserved.
//

import UIKit

class CloudKitViewControllerHeader: UIView {
    
    var didDone: (() -> Void)?
    private let padding = CGFloat(16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        
        let label = UILabel()
        label.text = "Review services!"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.sizeToFit()
        label.center = CGPoint(x: label.frame.size.width/2 + padding, y: 30)
        self.addSubview(label)
        
        let button = UIButton()
        button.setTitle("Done", for: .normal)
        button.setTitleColor(UIColor.orange, for: .normal)
        button.addTarget(self, action: #selector(handleButton), for: .touchUpInside)
        button.sizeToFit()
        button.center = CGPoint(x: frame.size.width - button.frame.size.width/2 - padding, y: 30)
        self.addSubview(button)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleButton() {
        didDone?()
    }
}
