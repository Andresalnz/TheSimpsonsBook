//
//  CharacterModelDTO.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 19/10/23.
//

import Foundation

// MARK: - Simpsons API DTOs

struct SimpsonsCharactersPageDTO: Codable, Identifiable, Hashable {
    let id: Int?
    let count: Int?
    let next: String?
    let prev: String?
    let pages: Int?
    let characters: [SimpsonsCharacterDTO]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case count
        case next
        case prev
        case pages
        case characters = "results"
    }
}

struct SimpsonsCharacterDTO: Codable, Identifiable, Hashable {
    let id: Int?
    let age: Int?
    let birthdate: String?
    let gender: SimpsonsCharacterGenderDTO?
    let name: String?
    let occupation: String?
    let portraitPath: String?
    let phrases: [String]?
    let status: SimpsonsCharacterStatusDTO?
    
    enum CodingKeys: String, CodingKey {
        case id
        case age
        case birthdate
        case gender
        case name
        case occupation
        case portraitPath = "portrait_path"
        case phrases
        case status
    }
}

enum SimpsonsCharacterStatusDTO: String, Codable, CaseIterable {
    case alive = "Alive"
    case deceased = "Deceased"
    case unknown = "Unknown"
}

enum SimpsonsCharacterGenderDTO: String, Codable, CaseIterable {
    case female = "Female"
    case male = "Male"
    case unknown = "unknown"
    case genderless = "Genderless"
}

/*
 {
   "count": 1182,
   "next": "https://thesimpsonsapi.com/api/characters?page=2",
   "prev": null,
   "pages": 60,
   "results": [
     {
       "id": 1,
       "age": 39,
       "birthdate": "1956-05-12",
       "gender": "Male",
       "name": "Homer Simpson",
       "occupation": "Safety Inspector",
       "portrait_path": "/character/1.webp",
       "phrases": ["Doh!", "..."],
       "status": "Alive"
     }
   ]
 }
 */
