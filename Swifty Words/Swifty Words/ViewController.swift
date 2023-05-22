//
//  ViewController.swift
//  Swifty Words
//
//  Created by Ali ÇAĞLAR on 10.05.2023.
//

import UIKit

class ViewController: UIViewController {
    var cluesLabel: UILabel!
    var answersLabel: UILabel!
    var scoreLabel: UILabel!
    var currentAnswer: UITextField!
    var letterButtons: [UIButton] = []
    
    let fontSize: Float = 24
    let buttonHeight: Float = 44
    
    let letterButtonWidth: Int = 150
    let letterButtonHeight: Int = 80
    let letterButtonFontSize: Float = 36
    
    var activatedButtons: [UIButton] = []
    var solutions: [String] = []
    var level: Int = 1
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        scoreLabel = createLabel(defaultText: "Score: 0")
        scoreLabel.textAlignment = .right
        
        cluesLabel = createLabel(defaultText: "CLUES")
        cluesLabel.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        cluesLabel.numberOfLines = 0
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        
        answersLabel = createLabel(defaultText: "ANSWERS")
        answersLabel.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        answersLabel.textAlignment = .right
        answersLabel.numberOfLines = 0
        answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.font = UIFont.systemFont(ofSize: CGFloat(fontSize * 2))
        currentAnswer.textAlignment = .center
        currentAnswer.placeholder = "Tap letters to guess answer"
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)
        
        let submitButton = createButton(text: "SUBMIT")
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        let clearButton = createButton(text: "CLEAR")
        clearButton.addTarget(self, action: #selector(clearButtonTapped), for: .touchUpInside)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        for x in 0..<5 {
            for y in 0..<4 {
                let button = UIButton(type: .system)
                button.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(letterButtonFontSize))
                
                button.setTitle("temp", for: .normal)
                button.addTarget(self, action: #selector(letterButtonTapped), for: .touchUpInside)
                
                let frame = CGRect(x: x * letterButtonWidth, y: y * letterButtonHeight, width: letterButtonWidth, height: letterButtonHeight)
                button.frame = frame
                
                buttonsView.addSubview(button)
                letterButtons.append(button)
            }
        }
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            // Top anchor is the score label
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor),
            
            // clues label
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
            cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),
            
            // answer label
            answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
            answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),
            
            // make same height
            answersLabel.heightAnchor.constraint(equalTo: cluesLabel.heightAnchor),
            
            // current answer
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),
            
            // clear and submit buttons
            submitButton.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
            clearButton.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            clearButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            submitButton.heightAnchor.constraint(equalToConstant: CGFloat(buttonHeight)),
            clearButton.heightAnchor.constraint(equalToConstant: CGFloat(buttonHeight)),
            
            // buttons view
            buttonsView.widthAnchor.constraint(equalToConstant: 750),
            buttonsView.heightAnchor.constraint(equalToConstant: 320),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: 20),
            buttonsView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -20),
            
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadLevel()
    }

    private func createLabel(defaultText text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        view.addSubview(label)
        return label
    }
    
    private func createButton(text: String) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(text, for: .normal)
        view.addSubview(button)
        return button
    }
    
    @objc private func letterButtonTapped(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else { return }
        currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
        activatedButtons.append(sender)
        sender.isHidden = true
    }
    
    @objc private func submitButtonTapped(_ sender: UIButton) {
        guard let userAnswer = currentAnswer.text else { return }
        
        if let userAnswerIndex = solutions.firstIndex(of: userAnswer) {
            activatedButtons.removeAll()

            var answers = answersLabel.text?.components(separatedBy: "\n")
            answers?[userAnswerIndex] = userAnswer
            answersLabel.text = answers?.joined(separator: "\n")
            
            currentAnswer.text = ""
            score += 1
            
            if score % solutions.count == 0 {
                let alertController = UIAlertController(title: "WIN", message: "Well done", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Next", style: .default, handler: levelUp))
                present(alertController, animated: true)
            }
            
        }
    }
    
    @objc private func clearButtonTapped(_ sender: UIButton) {
        currentAnswer.text = ""
        for button in activatedButtons {
            button.isHidden = false
        }
        
        activatedButtons.removeAll()
    }
    
    private func levelUp(action: UIAlertAction) {
        level += 1
        
        solutions.removeAll(keepingCapacity: true)
        loadLevel()
        
        for button in letterButtons {
            button.isHidden = false
        }
    }
    
    private func loadLevel() {
        var clues: String = ""
        var solutions: String = ""
        var letterBits: [String] = []
        
        guard let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt") else { return }
        guard let levelContents = try? String(contentsOf: levelFileURL) else { return }
        var lines = levelContents.components(separatedBy: "\n")
        lines.shuffle()
        
        for (index, line) in lines.enumerated() {
            let parts = line.components(separatedBy: ": ")
            let answer = parts[0]
            let clue = parts[1]
            
            clues += "\(index + 1)- \(clue)\n"
            
            let answerWord = answer.replacingOccurrences(of: "|", with: "")
            solutions += "\(answerWord.count) letters\n"
            self.solutions.append(answerWord)
            
            let bits = answer.components(separatedBy: "|")
            letterBits += bits
        }
        
        cluesLabel.text = clues.trimmingCharacters(in: .whitespacesAndNewlines)
        answersLabel.text = solutions.trimmingCharacters(in: .whitespacesAndNewlines)
        
        letterButtons.shuffle()
        
        if letterButtons.count != letterBits.count { return }
        for i in 0..<letterButtons.count {
            letterButtons[i].setTitle(letterBits[i], for: .normal)
        }
    }

}

