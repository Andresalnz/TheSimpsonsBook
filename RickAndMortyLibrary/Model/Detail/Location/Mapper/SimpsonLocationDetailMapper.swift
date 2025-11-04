//
//  SimpsonLocationDetailMapper.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 28/10/25.
//

import Foundation

// MARK: - Simpsons Location Detail Mapper
extension SimpsonsLocationDetailDTO {
    func toBo() -> SimpsonsLocationDetailBO {
        SimpsonsLocationDetailBO(locationDetailId: locationDetailId,
                                 description: description,
                                 firstAppearanceEpId: firstAppearanceEpId,
                                 firstAppearanceShId: firstAppearanceShId,
                                 imagePath: URL(string: "https://cdn.thesimpsonsapi.com/500\(imagePath ?? "")"),
                                 name: name,
                                 town: town,
                                 use: use,
                                 firstAppearanceSh: firstAppearanceSh?.toBo(),
                                 firstAppearanceEp: firstAppearanceEp?.toBo())
    }
}


// MARK: - First Appearance (Episode/Short) Mapper
extension SimpsonsFirstAppearanceLocationDTO {
    func toBo() -> SimpsonsFirstAppearanceLocationBO {
        SimpsonsFirstAppearanceLocationBO(
            firstAppearanceId: firstAppearanceId,
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
