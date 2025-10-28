//
//  SimpsonsLocationBO.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 28/10/25.
//

import Foundation

// MARK: - Simpsons Location Detail BO
struct SimpsonsLocationDetailBO: Codable, Identifiable, Hashable {
    let id: Int?
    let name: String?
    let imagePath: URL?
    let town: String?
    let use: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imagePath = "image_path"
        case town
        case use
    }
}
