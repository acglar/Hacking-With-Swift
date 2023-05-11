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
        let clearButton = createButton(text: "CLEAR")
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonsView)
        
        for x in 0..<5 {
            for y in 0..<4 {
                let button = UIButton(type: .system)
                button.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(letterButtonFontSize))
                
                button.setTitle("temp", for: .normal)
                
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
        
        answersLabel.backgroundColor = .red
        cluesLabel.backgroundColor = .blue
        buttonsView.backgroundColor = .green
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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

}

