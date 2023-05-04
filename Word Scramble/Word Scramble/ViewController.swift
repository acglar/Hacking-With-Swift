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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(startGame))
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
    
    @objc private func promptForAnswer() {
        let alertController = UIAlertController(title: "Answer", message: nil, preferredStyle: .alert)
        alertController.addTextField()
        
        let submitAnswer = UIAlertAction(title: "Submit", style: .default) { [weak self, weak alertController] _ in
            guard let answer = alertController?.textFields?[0].text else { return }
            self?.submit(answer: answer)
        }
        
        alertController.addAction(submitAnswer)
        present(alertController, animated: true)
    }
    
    private func submit(answer: String) {
        let lowerCasedAnswer = answer.lowercased()
        
        if isValid(word: lowerCasedAnswer) {
            usedWords.insert(lowerCasedAnswer, at: 0)
            
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
    private func showErrorMessage(errorTitle: String, errorMessage: String) {
        let alertController = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alertController, animated: true)
    }
    
    private func isValid(word: String) -> Bool {
        return isPossible(word: word) && isOriginal(word: word) && isReal(word: word)
    }
    
    private func isOriginal(word: String) -> Bool {
        if usedWords.contains(word) {
            showErrorMessage(errorTitle: "Word used already", errorMessage: "Try another")
        }

        return !usedWords.contains(word)
    }
    
    private func isPossible(word: String) -> Bool {
        guard var anagramWord = title?.lowercased() else { return false }
        
        if word.count <= 3 {
            showErrorMessage(errorTitle: "Too short", errorMessage: "Word needs to be at least 4 letter")
            return false
        }
        
        for letter in word {
            if let index = anagramWord.firstIndex(of: letter) {
                anagramWord.remove(at: index)
            } else {
                guard let title = title?.lowercased() else { return false }
                showErrorMessage(errorTitle: "That's not anagram", errorMessage: "You can't create that word from \(title)")
                return false
            }
        }
        
        return true
    }
    
    private func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        if misspelledRange.location != NSNotFound {
            showErrorMessage(errorTitle: "Word couldn't recognised", errorMessage: "There's no such word")
        }

        return misspelledRange.location == NSNotFound
    }
    
    @objc private func startGame() {
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

