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
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white
        
        scoreLabel = createLabel(defaultText: "Score: 0")
        scoreLabel.textAlignment = .right
        
        cluesLabel = createLabel(defaultText: "CLUES")
        cluesLabel.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        cluesLabel.numberOfLines = 0
        
        answersLabel = createLabel(defaultText: "ANSWERS")
        answersLabel.font = UIFont.systemFont(ofSize: CGFloat(fontSize))
        answersLabel.textAlignment = .right
        answersLabel.numberOfLines = 0
        
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
        ])
        
        answersLabel.backgroundColor = .red
        cluesLabel.backgroundColor = .blue
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

}

