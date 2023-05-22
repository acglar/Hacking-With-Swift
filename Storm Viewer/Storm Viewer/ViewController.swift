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
        
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let fileManager = FileManager.default
        let resourcePath = Bundle.main.resourcePath!
        let items = try! fileManager.contentsOfDirectory(atPath: resourcePath)
        
        for item in items {
            if !item.hasPrefix("nssl") { continue }
            picturePaths.append(item)
        }
        
        picturePaths.sort()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return picturePaths.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        let pictureName = getPictureNameBy(cellIndex: indexPath.row)
        cell.textLabel?.text = pictureName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailViewController = storyboard?.instantiateViewController(withIdentifier: "Detail")
            as? DetailViewController {
            detailViewController.imagePath = picturePaths[indexPath.row]
            detailViewController.imageName = getPictureNameBy(cellIndex: indexPath.row)
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    }

    func getPictureNameBy(cellIndex index: Int) -> String {
        return "Picture \(index + 1) of \(picturePaths.count)"
    }
}
