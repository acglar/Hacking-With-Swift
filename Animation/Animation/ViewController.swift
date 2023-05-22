//
//  ViewController.swift
//  Animation
//
//  Created by Ali ÇAĞLAR on 20.05.2023.
//

import UIKit

class ViewController: UIViewController {
    var imageView: UIImageView!
    var animationIndex: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView(image: UIImage(named: "penguin"))
        imageView.center = view.center
        view.addSubview(imageView)
    }

    @IBAction func onTapButtonClicked(_ sender: UIButton) {
        sender.isHidden = true
        
        UIView.animate(withDuration: 1, delay: 0, animations: {
            switch self.animationIndex {
            case 0:
                self.imageView.transform = CGAffineTransform(scaleX: 2, y: 2)
            case 2:
                self.imageView.transform = CGAffineTransform(translationX: -100, y: -200)
            case 4:
                self.imageView.transform = CGAffineTransform(rotationAngle: .pi)
            case 6:
                self.imageView.alpha = 0.1
                self.imageView.backgroundColor = .green
            case 7:
                self.imageView.alpha = 1
                self.imageView.backgroundColor = .clear
            default:
                break
            }
            
            if self.animationIndex != 7 && self.animationIndex % 2 != 0 {
                self.imageView.transform = .identity
            }
        }, completion: { _ in
            sender.isHidden = false
        })
        
        // increase animation index
        animationIndex += 1
        
        if animationIndex > 7 {
            animationIndex = 0
        }
    }
    
}

