//
//  ConsentKitCell.swift
//  ConsentIos
//
//  Created by Cristian Baluta on 21/05/2018.
//  Copyright © 2018 Cristian Baluta. All rights reserved.
//

import UIKit

class ConsentKitCell: UITableViewCell {

    private var switchButton: UISwitch
    var valueChanged: ((UISwitch) -> Void)?
    var defaultValue: Bool = false {
        didSet {
            switchButton.isOn = defaultValue
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {

        switchButton = UISwitch(frame: .zero)
        switchButton.onTintColor = UIColor.orange
        switchButton.setOn(false, animated: true)

        super.init(style: style, reuseIdentifier: reuseIdentifier)

        switchButton.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        self.accessoryView = switchButton
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func switchChanged(_ sender: UISwitch) {
        valueChanged?(sender)
    }
}
