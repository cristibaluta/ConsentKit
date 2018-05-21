//
//  ConsentKitViewController.swift
//  ConsentIos
//
//  Created by Cristian Baluta on 21/05/2018.
//  Copyright © 2018 Cristian Baluta. All rights reserved.
//

import UIKit

class ConsentKitViewController: UITableViewController {

    var didAccept: ((ConsentKitItem) -> Void)?
    var didReject: ((ConsentKitItem) -> Void)?
    var items: [ConsentKitItem] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    var defaultValues: [Bool] = []
    fileprivate let gdpr = ConsentKit()

    override func viewDidLoad() {
        super.viewDidLoad()
        let header = CloudKitViewControllerHeader(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 80))
        header.didDone = {
            // Set to false the untouched switches to prevent gdpr being called again
            for item in self.items {
                if !self.gdpr.isReviewed(item) {
                    self.gdpr.set(false, for: item)
                }
            }
            self.dismiss(animated: true, completion: nil)
        }
        tableView.tableHeaderView = header
        tableView.tableFooterView = UIView()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let item = items[indexPath.row]
        let cell = ConsentKitCell(style: .subtitle, reuseIdentifier: nil)
        cell.textLabel?.text = item.title()
        cell.detailTextLabel?.text = item.description()
        cell.detailTextLabel?.numberOfLines = 0
        cell.valueChanged = { switchButton in
            self.switchChanged(switchButton, with: item)
        }
        cell.defaultValue = defaultValues[indexPath.row]
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Switch changed

    func switchChanged(_ switchButton: UISwitch, with item: ConsentKitItem) {

        if switchButton.isOn {
            let alert = UIAlertController(title: "Consent", message: item.alertDescription(), preferredStyle: .alert)
            alert.addAction(
                UIAlertAction(title: "Accept", style: .default, handler: { _ in
                    self.gdpr.set(true, for: item)
                    self.didAccept?(item)
                })
            )
            alert.addAction(
                UIAlertAction(title: "Decline", style: .cancel, handler: { _ in
                    switchButton.isOn = false
                    self.gdpr.set(false, for: item)
                    self.didReject?(item)
                })
            )
            self.present(alert, animated: true, completion: nil)
        } else {
            self.didReject?(item)
        }
    }
}
