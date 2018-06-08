//
//  ConsentKitTableViewDataSource.swift
//  Gdpr
//
//  Created by Cristian Baluta on 05/06/2018.
//  Copyright © 2018 Imagin soft. All rights reserved.
//

import UIKit

class ConsentKitTableViewDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {

    var items: [ConsentKitItem] = []

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let item = items[indexPath.row]
        var cell: ConsentKitCellProtocol = ConsentKitCell.instantiateFromXib()
        cell.title = item.title()
        cell.subtitle = item.description()
        cell.value = gdpr.isAccepted(item)
        cell.valueDidChange = { isOn in
            self.item(item, didChangeValue: isOn, in: cell)
        }

        return cell as! ConsentKitCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func item(_ item: ConsentKitItem, didChangeValue value: Bool, in cell: ConsentKitCellProtocol) {

        if value {
            guard let message = item.alertMessage() else {
                self.gdpr.setAccepted(true, for: item)
                self.didAccept?(item)
                return
            }
            let alert = UIAlertController(title: item.title(), message: message, preferredStyle: .alert)
            alert.addAction(
                UIAlertAction(title: "Accept", style: .default, handler: { _ in
                    self.gdpr.setAccepted(true, for: item)
                    self.didAccept?(item)
                })
            )
            alert.addAction(
                UIAlertAction(title: "Decline", style: .cancel, handler: { _ in
                    var cell = cell
                    cell.value = false
                    self.gdpr.setAccepted(false, for: item)
                    self.didReject?(item)
                })
            )
            self.present(alert, animated: true, completion: nil)
        } else {
            self.gdpr.setAccepted(false, for: item)
            didReject?(item)
        }
    }
}
