//
//  ViewController.swift
//  Word Scramble
//
//  Created by Ali ÇAĞLAR on 2.05.2023.
//

import UIKit

class ViewController: UITableViewController {
    private let reuseIdentifier: String = "Word"
    private var allWords: [String] = []
    private var usedWords: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !loadWordsFromResource() {
            allWords = ["silkworm"]
        }
        
        startGame()
    }
    
    internal override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    internal override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = usedWords[indexPath.row]
        cell.contentConfiguration = content
        return cell
    }
    
    private func startGame() {
        usedWords.removeAll(keepingCapacity: true)
        tableView.reloadData()
        title = allWords.randomElement()
    }
    
    private func loadWordsFromResource() -> Bool {
        guard let wordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") else { return false }
        guard let words = try? String(contentsOf: wordsURL) else { return false }
        allWords = words.components(separatedBy: "\n")
        return true
    }


}

