//
//  ViewController.swift
//  Guess The Flag
//
//  Created by Ali ÇAĞLAR on 23.04.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var firstButton: UIButton!
    @IBOutlet var secondButton: UIButton!
    @IBOutlet var thirdButton: UIButton!
    
    let countries: [String] = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    var availableCountries: [String] = []
    var score: Int = 0
    var correctAnswer: Int = 0
    var askedQuestionCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        availableCountries += countries
        addBorderToButtons(width: 1)
        changeBorderColor(uiColor: .lightGray)
        
        askQuestion()
    }
    
    func addBorderToButtons(width: CGFloat) {
        firstButton.layer.borderWidth = width
        secondButton.layer.borderWidth = width
        thirdButton.layer.borderWidth = width
    }
    
    func changeBorderColor(uiColor: UIColor) {
        firstButton.layer.borderColor = uiColor.cgColor
        secondButton.layer.borderColor = uiColor.cgColor
        thirdButton.layer.borderColor = uiColor.cgColor
    }
    
    func askQuestion(action: UIAlertAction! = nil) {
        availableCountries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        askedQuestionCount += 1
        
        firstButton.setImage(UIImage(named: availableCountries[0]), for: .normal)
        secondButton.setImage(UIImage(named: availableCountries[1]), for: .normal)
        thirdButton.setImage(UIImage(named: availableCountries[2]), for: .normal)
        
        let question = availableCountries[correctAnswer]
        let playerScore = "Score: \(score)"
        title = ("\(question) \(playerScore)").uppercased()
    }
    
    func quitApp(action: UIAlertAction! = nil) {
        exit(0)
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let title = sender.tag == correctAnswer ? "Correct" : "Wrong"
        score += sender.tag == correctAnswer ? 1 : -1
        let scoreMessage = "Your score is \(score)"
        var messageToShow = sender.tag == correctAnswer ? scoreMessage : "You choose the \(availableCountries[sender.tag].uppercased()) Flag.\n\(scoreMessage)"
        
        if (askedQuestionCount >= 10) {
            messageToShow = "You guessed right \(score >= 0 ? score : 0) out of 10 question."
        }
        
        let alertController = UIAlertController(title: title, message: messageToShow, preferredStyle: .alert)
        let alertActionTitle = askedQuestionCount < 10 ? "Continue" : "OK"
        let alertActionHandler = askedQuestionCount < 10 ? askQuestion : quitApp
        
        alertController.addAction(UIAlertAction(title: alertActionTitle, style: .default, handler: alertActionHandler))
        
        present(alertController, animated: true)
    }
}
