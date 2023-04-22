//
//  ViewController.swift
//  Storm Viewer
//
//  Created by Ali ÇAĞLAR on 22.04.2023.
//

import UIKit

class ViewController: UITableViewController {
    var picturePaths : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fileManager = FileManager.default
        let resourcePath = Bundle.main.resourcePath!
        let items = try! fileManager.contentsOfDirectory(atPath: resourcePath)
        
        for item in items {
            if !item.hasPrefix("nssl") { continue }
            picturePaths.append(item)
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return picturePaths.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = picturePaths[indexPath.row]
        return cell
    }
}

