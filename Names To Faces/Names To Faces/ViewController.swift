//
//  ViewController.swift
//  Names To Faces
//
//  Created by Ali ÇAĞLAR on 14.05.2023.
//

import UIKit

class ViewController: UICollectionViewController {
    let cellIdentifier: String = "PersonCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewImage))
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return persons.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? PersonCell else {
            fatalError("Couldn't find PersonCell class.")
        }
        
        let person = persons[indexPath.item]
        
        cell.nameLabel.text = person.name
        
        let imagePath = getDocumentsDirectory().appending(component: person.image)
        cell.imageView.image = UIImage(contentsOfFile: imagePath.path())
        
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        
        return cell
    }
    
    @objc private func addNewImage() {
        let pickerController = UIImagePickerController()
        pickerController.allowsEditing = true
        pickerController.delegate = self
        present(pickerController, animated: true)
    }
    
    }
    }


}

