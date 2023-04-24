//
//  DetailViewController.swift
//  Storm Viewer
//
//  Created by Ali ÇAĞLAR on 22.04.2023.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var imagePath: String?
    var imageName: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let name = imageName {
            title = name
        } else if let fileName = imagePath {
            title = (fileName as NSString).deletingPathExtension
        }

        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButtonTapped))

        if let imageToLoad = imagePath {
            imageView.image = UIImage(named: imageToLoad)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
    
    @objc func shareButtonTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            print("Couldn't retrieve jpeg data.")
            return
        }
        
        let viewController = UIActivityViewController(activityItems: [image], applicationActivities: [])
        viewController.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(viewController, animated: true)
    }
}
