//
//  EpisodeMapper.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 20/10/23.
//

import Foundation

extension SimpsonsEpisodeDTO {
    func toBo() -> SimpsonsEpisodeBO {
        SimpsonsEpisodeBO(id: id,
                          airdate: airdate,
                          episodeNumber: episodeNumber,
                          imagePath: URL(string: imagePath ?? ""),
                          name: name,
                          season: season,
                          synopsis: synopsis)
    }
}





