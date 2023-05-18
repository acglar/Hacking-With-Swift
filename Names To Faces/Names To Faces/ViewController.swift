//
//  ViewController.swift
//  Names To Faces
//
//  Created by Ali ÇAĞLAR on 14.05.2023.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let cellIdentifier: String = "PersonCell"
    var persons: [Person] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let person = persons[indexPath.item]
        
        let alertController = UIAlertController(title: "Rename", message: nil, preferredStyle: .alert)
        alertController.addTextField()
        
        alertController.addAction(UIAlertAction(title: "Ok", style: .default) { [weak self, weak alertController] _ in
            guard let name = alertController?.textFields?[0].text else { return }
            person.name = name
            self?.save()
            self?.collectionView.reloadData()
        })
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.addAction(UIAlertAction(title: "Delete", style: .default) { [weak self] _ in
            self?.persons.remove(at: indexPath.item)
            self?.save()
            self?.collectionView.reloadData()
        })
        
        present(alertController, animated: true)
    }
    
    @objc private func addNewImage() {
        let pickerController = UIImagePickerController()
        pickerController.allowsEditing = true
        pickerController.delegate = self
        present(pickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else { return }
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appending(component: imageName)
        
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        
        let person = Person(name: "Unknown", image: imageName)
        persons.append(person)
        save()
        collectionView.reloadData()
        
        dismiss(animated: true)
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func save() {
        if let dataToSave = try? NSKeyedArchiver.archivedData(withRootObject: persons, requiringSecureCoding: false) {
            let defaults = UserDefaults.standard
            defaults.set(dataToSave, forKey: "persons")
        }
    }
    
    private func loadData() {
        let defaults = UserDefaults.standard
        guard let data = defaults.object(forKey: "persons") as? Data else { return }
        if let unarchiever = try? NSKeyedUnarchiver.init(forReadingFrom: data) {
            unarchiever.requiresSecureCoding = false
            if let savedData = unarchiever.decodeObject(forKey: NSKeyedArchiveRootObjectKey) as? [Person] {
                persons = savedData
            }
        }
    }


}

