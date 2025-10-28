//
//  SimpsonsEpisodeDetailMapper.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 28/10/25.
//

import Foundation

// MARK: - Simpsons Episode Detail Mapper
extension SimpsonsEpisodeDetailDTO {
    func toBo() -> SimpsonsEpisodeDetailBO {
        SimpsonsEpisodeDetailBO(id: id,
                                airdate: airdate,
                                episodeNumber: episodeNumber,
                                imagePath: URL(string: imagePath ?? ""),
                                name: name,
                                season: season,
                                synopsis: synopsis)
    }
}
