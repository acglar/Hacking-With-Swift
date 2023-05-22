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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
