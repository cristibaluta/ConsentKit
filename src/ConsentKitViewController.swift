//
//  ConsentKitViewController.swift
//  Gdpr
//
//  Created by Cristian Baluta on 21/05/2018.
//  Copyright © 2018 Cristian Baluta. All rights reserved.
//

import UIKit

class ConsentKitViewController: UITableViewController {

    var didAccept: ((ConsentKitItem) -> Void)?
    var didReject: ((ConsentKitItem) -> Void)?
    var didFinishReview: (() -> Void)?
    var items: [ConsentKitItem] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    fileprivate let gdpr = ConsentKit()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if self.navigationController == nil {
            // Add a custom header only if the VC is not pushed into a navigationController
            let header = CloudKitViewControllerHeader(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 80))
            header.didDone = {
                self.handleDone()
                self.dismiss(animated: true, completion: nil)
            }
            tableView.tableHeaderView = header
        } else {
            self.title = "Review services!"
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(handleDone))
        }
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
        cell.defaultValue = gdpr.isAccepted(item)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    // MARK: - Switch changed

    func switchChanged(_ switchButton: UISwitch, with item: ConsentKitItem) {

        if switchButton.isOn {
            let alert = UIAlertController(title: item.title(), message: item.alertMessage(), preferredStyle: .alert)
            alert.addAction(
                UIAlertAction(title: "Accept", style: .default, handler: { _ in
                    self.gdpr.setAccepted(true, for: item)
                    self.didAccept?(item)
                })
            )
            alert.addAction(
                UIAlertAction(title: "Decline", style: .cancel, handler: { _ in
                    switchButton.isOn = false
                    self.gdpr.setAccepted(false, for: item)
                    self.didReject?(item)
                })
            )
            self.present(alert, animated: true, completion: nil)
        } else {
            didReject?(item)
        }
    }
    
    @objc func handleDone() {
        // Set to false the untouched switches, to prevent gdpr being called again
        for item in items {
            if !gdpr.isReviewed(item) {
                gdpr.setAccepted(false, for: item)
            }
        }
        didFinishReview?()
    }
}
