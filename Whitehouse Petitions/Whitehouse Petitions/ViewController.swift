//
//  ViewController.swift
//  Whitehouse Petitions
//
//  Created by Ali ÇAĞLAR on 7.05.2023.
//

import UIKit

class ViewController: UITableViewController {
    let tableViewCellIdentifier: String = "Cell"
    var petitions: [Petition] = []
    var urlString: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(showCredits))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchKeyword))
        
        tryParseData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewCellIdentifier, for: indexPath)
        var content = cell.defaultContentConfiguration()
        let petition = petitions[indexPath.row]
        content.text = petition.title
        content.secondaryText = petition.body
        cell.contentConfiguration = content
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = DetailViewController()
        detailController.petition = petitions[indexPath.row]
        navigationController?.pushViewController(detailController, animated: true)
    }
    
    private func tryParseData() {
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        
        showError()
    }
    
    private func parse(json data: Data) {
        let decoder = JSONDecoder()
        
        guard let jsonData = try? decoder.decode(Petitions.self, from: data) else { return }
        petitions = jsonData.results
        tableView.reloadData()
    }
    
    private func showError() {
        let alertController = UIAlertController(title: "No Connection", message: "Check your network connection", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alertController, animated: true)
    }
    
    @objc private func showCredits() {
        let alertController = UIAlertController(title: "Credits", message: "Thanks to hacking with swift for the cached api", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Thanks", style: .default))
        present(alertController, animated: true)
    }
    
    @objc private func searchKeyword() {
        let alertController = UIAlertController(title: "What are you looking for", message: nil, preferredStyle: .alert)
        alertController.addTextField()
        
        let searchFor = UIAlertAction(title: "Search", style: .default) { [weak alertController, weak self] _ in
            guard let keyword = alertController?.textFields?[0].text else { return }
            self?.search(for: keyword)
        }
        
        alertController.addAction(searchFor)
        present(alertController, animated: true) {
            alertController.textFields?[0].becomeFirstResponder()
        }
    }
    
    private func search(for keyword: String) {
        petitions = petitions.filter { $0.title.localizedCaseInsensitiveContains(keyword) != false }
        tableView.reloadData()
    }


}

