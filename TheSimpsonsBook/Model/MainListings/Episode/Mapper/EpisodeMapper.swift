//
//  EpisodeMapper.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 20/10/23.
//

import Foundation

extension SimpsonsEpisodeDTO {
    func toBo() -> SimpsonsEpisodeBO {
      SimpsonsEpisodeBO(episodeId: episodeId,
                        airdate: airdate,
                        episodeNumber: episodeNumber,
                        imagePath: URL(string: "https://cdn.thesimpsonsapi.com/500\(imagePath ?? "")"),
                        name: name,
                        season: season,
                        synopsis: synopsis)
    }
}
