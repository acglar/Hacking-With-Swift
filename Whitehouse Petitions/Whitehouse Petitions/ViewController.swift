//
//  ViewController.swift
//  Whitehouse Petitions
//
//  Created by Ali ÇAĞLAR on 7.05.2023.
//

import UIKit

class ViewController: UITableViewController {
    let navigationControllerID: String = "NavController"
    let tableViewCellIdentifier: String = "Cell"
    var petitions: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = "Title Spot"
        content.secondaryText = "Subtitle Spot"
        cell.contentConfiguration = content
        return cell
    }


}

