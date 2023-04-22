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
        
        print(picturePaths)
    }


}

