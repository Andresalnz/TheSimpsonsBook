//
//  SimpsonsCharacterDetailMapper.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 28/10/25.
//

import Foundation

// MARK: - Simpsons Character Detail Mapper
extension SimpsonsCharacterDetailDTO {
    func toBo() -> SimpsonsCharacterDetailBO {
        SimpsonsCharacterDetailBO(
            characterDetailId: characterDetailId,
            age: "\(age ?? 0)",
            birthdate: birthdate,
            description: description,
            firstAppearanceEpId: firstAppearanceEpId,
            firstAppearanceShId: firstAppearanceShId,
            gender: gender,
            name: name,
            occupation: occupation,
            phrases: phrases,
            portraitPath: URL(string: "https://cdn.thesimpsonsapi.com/500\(portraitPath ?? "")"),
            status: status,
            firstAppearanceEp: firstAppearanceEp?.toBo(),
            firstAppearanceSh: firstAppearanceSh?.toBo()
        )
    }
}

// MARK: - First Appearance (Episode/Short) Mapper
extension SimpsonsFirstAppearanceCharacterDTO {
    func toBo() -> SimpsonsFirstAppearanceCharacterBO {
        SimpsonsFirstAppearanceCharacterBO(
            firstAppearanceId: firstAppearanceId,
            airdate: airdate,
            description: description,
            episodeNumber: episodeNumber,
            imagePath: URL(string: "https://cdn.thesimpsonsapi.com/500\(imagePath ?? "")"),
            name: name,
            season: season,
            synopsis: synopsis
        )
    }
}

