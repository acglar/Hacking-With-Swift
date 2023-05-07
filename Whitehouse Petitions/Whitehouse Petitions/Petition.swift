//
//  Petition.swift
//  Whitehouse Petitions
//
//  Created by Ali ÇAĞLAR on 7.05.2023.
//

import Foundation

public struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}
