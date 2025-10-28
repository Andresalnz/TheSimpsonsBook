//
//  CharacterModelBO.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 19/10/23.
//

import Foundation

// MARK: - Simpsons API BOs (reemplaza el modelo anterior)

struct SimpsonsCharactersPageBO: Codable {
    let count: Int?
    let next: URL?
    let prev: URL?
    let pages: Int?
    let characters: [SimpsonsCharacterBO]?
    
    enum CodingKeys: String, CodingKey {
        case count
        case next
        case prev
        case pages
        case characters = "results"
    }
}

struct SimpsonsCharacterBO: Codable, Identifiable, Hashable {
    let id: UUID = UUID()
    
    let characterId: Int?
    let age: Int?
    let birthdate: String?
    let gender: SimpsonsCharacterGenderBO?
    let name: String?
    let occupation: String?
    let portraitPath: String?
    let phrases: [String]?
    let status: SimpsonsCharacterStatusBO?
    
    enum CodingKeys: String, CodingKey {
        case characterId = "id"
        case age
        case birthdate
        case gender
        case name
        case occupation
        case portraitPath = "portrait_path"
        case phrases
        case status
    }
    
    var imageURL: URL? {
        guard let portraitPath  else { return nil }
        return URL(string: "https://cdn.thesimpsonsapi.com/200\(portraitPath)")
    }
}

// MARK: - Tipos compartidos que ya usa el proyecto y que se mantienen

struct LocationOriginBO: Codable, Identifiable, Hashable {
    let id: Int?
    let name: String?
    let url: URL?
}

//MARK: - enum Gender, Species & Status (Rick and Morty) necesarios en otras capas

enum SimpsonsCharacterGenderBO: String, Codable, CaseIterable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
    case Genderless = "Genderless"
}


enum SimpsonsCharacterStatusBO: String, Codable, CaseIterable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}


//extension SimpsonsCharacterDTO {
//    var imageURL: URL? {
//        URL(string: "https://cdn.thesimpsonsapi.com/500\(portraitPath ?? "")")
//    }
//}
