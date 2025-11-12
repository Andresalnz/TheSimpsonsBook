//
//  CharacterMapper.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 19/10/23.
//

import Foundation

// MARK: - Simpsons DTO -> BO Mappers
extension SimpsonsCharacterDTO {
    func toBo() -> SimpsonsCharacterBO {
        SimpsonsCharacterBO(
            characterId: characterId,
            age: age,
            birthdate: birthdate,
            gender: gender?.toBo(),
            name: name,
            occupation: occupation,
            portraitPath: URL(string: "https://cdn.thesimpsonsapi.com/500\(portraitPath ?? "")"),
            phrases: phrases,
            status: status?.toBo()
        )
    }
}

// MARK: - Enum Mappers
extension SimpsonsCharacterGenderDTO {
    func toBo() -> SimpsonsCharacterGenderBO {
        switch self {
        case .female: return .female
        case .male: return .male
        case .unknown: return .unknown
        case .genderless: return .Genderless
        }
    }
}

extension SimpsonsCharacterStatusDTO {
    func toBo() -> SimpsonsCharacterStatusBO {
        switch self {
        case .alive: return .alive
        case .deceased: return .dead
        case .unknown: return .unknown
        }
    }
}
