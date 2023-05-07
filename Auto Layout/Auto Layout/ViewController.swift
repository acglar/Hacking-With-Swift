//
//  ViewController.swift
//  Auto Layout
//
//  Created by Ali ÇAĞLAR on 6.05.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createLabels()
    }

    private func createLabels() {
        let sentence = "These are some awesome labels"
        let words = sentence.uppercased().components(separatedBy: " ")
        let colors = [UIColor.red, UIColor.green, UIColor.blue, UIColor.yellow, UIColor.magenta]
        //var viewsDictionary: [String:UILabel] = [:]
        
        var previousLabel: UILabel?
        for i in 0..<5 {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.text = words[i]
            label.backgroundColor = colors[i]
            label.sizeToFit()
            
            view.addSubview(label)
            //viewsDictionary["label\(i)"] = label
            
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            label.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2).isActive = true
            
            if let previous = previousLabel {
                label.topAnchor.constraint(equalTo: previous.bottomAnchor, constant: 10).isActive = true
            } else {
                label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
            }
            
            previousLabel = label
        }
        
//        for label in viewsDictionary.keys {
//            view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[\(label)]|", options: [], metrics: nil, views: viewsDictionary))
//        }
//
//        let metrics = ["labelHeight": 80]
//
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[label0(labelHeight@999)]-[label1(label0)]-[label2(label0)]-[label3(label0)]-[label4(label0)]-(>=10)-|", options: [], metrics: metrics, views: viewsDictionary))
    }

}

