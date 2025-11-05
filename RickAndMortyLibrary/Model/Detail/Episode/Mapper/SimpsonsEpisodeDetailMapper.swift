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
        SimpsonsEpisodeDetailBO(episodeDetailId: episodeDetailId,
                                airdate: airdate,
                                description: description,
                                episodeNumber: "\(episodeNumber ?? 0)",
                                imagePath: URL(string: "https://cdn.thesimpsonsapi.com/500\(imagePath ?? "")"),
                                name: name,
                                season: "\(season ?? 0)",
                                synopsis: synopsis)
    }
}
