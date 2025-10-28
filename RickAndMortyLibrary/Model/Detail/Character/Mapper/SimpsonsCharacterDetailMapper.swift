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
            id: id,
            age: age,
            birthdate: birthdate,
            description: description,
            firstAppearanceEpId: firstAppearanceEpId,
            firstAppearanceShId: firstAppearanceShId,
            gender: gender?.toBo(),
            name: name,
            occupation: occupation,
            phrases: phrases,
            portraitPath: URL(string: portraitPath ?? ""),
            status: status,
            firstAppearanceEp: firstAppearanceEp?.toBo(),
            firstAppearanceSh: firstAppearanceSh?.toBo()
        )
    }
}

// MARK: - First Appearance (Episode/Short) Mapper
extension SimpsonsFirstAppearanceDTO {
    func toBo() -> SimpsonsFirstAppearanceBO {
        SimpsonsFirstAppearanceBO(
            id: id,
            airdate: airdate,
            description: description,
            episodeNumber: episodeNumber,
            imagePath: URL(string: imagePath ?? ""),
            name: name,
            season: season,
            synopsis: synopsis
        )
    }
}

