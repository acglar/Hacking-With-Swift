//
//  Person.swift
//  Names To Faces
//
//  Created by Ali ÇAĞLAR on 16.05.2023.
//

import UIKit

class Person: NSObject, Codable {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
