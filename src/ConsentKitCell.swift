//
//  ConsentKitCell.swift
//
//  Created by Cristian Baluta on 21/05/2018.
//  Copyright © 2018 Cristian Baluta. All rights reserved.
//

import UIKit

class ConsentKitCell: UITableViewCell, ConsentKitCellProtocol {

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    @IBOutlet private var switchButton: UISwitch!
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    var subtitle: String = "" {
        didSet {
            subtitleLabel.text = subtitle
        }
    }
    var value: Bool = false {
        didSet {
            switchButton.isOn = value
        }
    }
    var valueDidChange: ((Bool) -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        switchButton.onTintColor = UIColor.orange
    }

    static func instantiateFromXib() -> ConsentKitCell {
        let arrNib: Array = Bundle.main.loadNibNamed("ConsentKitCell", owner: self, options: nil)!
        return arrNib.first as! ConsentKitCell
    }

    @IBAction func switchChanged(_ sender: UISwitch) {
        valueDidChange?(sender.isOn)
    }
}
