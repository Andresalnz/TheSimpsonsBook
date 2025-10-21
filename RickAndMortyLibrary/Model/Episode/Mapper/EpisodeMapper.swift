//
//  EpisodeMapper.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 20/10/23.
//

import Foundation

extension SimpsonsEpisodeDTO {
    func toBo() -> SimpsonsEpisodeBO {
        SimpsonsEpisodeBO(airdate: airdate,
                          episodeNumber: episodeNumber,
                          imagePath: imagePath,
                          name: name,
                          season: season,
                          synopsis: synopsis)
    }
}





