//
//  ViewController.swift
//  Insta Filter
//
//  Created by Ali ÇAĞLAR on 19.05.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var intensitySlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = "Insta Filter"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(importImage))
    }

    @IBAction func onChangeFilterButtonClick(_ sender: Any) {
    }
    
    @IBAction func onSaveButtonClick(_ sender: Any) {
    }
    
    @IBAction func onIntensityValueChanged(_ sender: Any) {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        currentImage = image
        initFiltering()
        dismiss(animated: true)
    }
    
    @objc private func importImage() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    }
}

