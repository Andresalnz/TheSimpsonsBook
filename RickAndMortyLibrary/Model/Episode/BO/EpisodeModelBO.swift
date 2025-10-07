//
//  EpisodeModelBO.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 20/10/23.
//

import Foundation

// MARK: - Simpsons Episodes BO

struct SimpsonsEpisodesPageBO: Codable,  Hashable, Identifiable {
    let id: Int?
    let count: Int?
    let next: URL?
    let prev: URL?
    let pages: Int?
    let episodes: [SimpsonsEpisodeBO]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case count
        case next
        case prev
        case pages
        case episodes = "results"
    }
}

struct SimpsonsEpisodeBO: Codable, Hashable, Identifiable {
    // Identifiable
    let id: Int?
    
    // Datos propios del episodio
    let airdate: String?
    let episodeNumber: Int?
    let imagePath: URL?
    let name: String?
    let season: Int?
    let synopsis: String?
    
    // Modelos auxiliares para UI existentes en el proyecto
//    var rowListMain: RowListMain {
//        RowListMain(image: imagePath, name: name)
//    }
//    
//    var rowDetail: RowDetail {
//        RowDetail(
//            airDate: airdate,
//            episode: formattedEpisodeCode,
//            characters: nil,
//            dimension: nil,
//            residents: nil,
//            type: nil,
//            status: nil,
//            gender: nil,
//            origin: nil,
//            location: nil,
//            episodes: nil,
//            image: imagePath,
//            name: name
//        )
//    }
    
    // Helper para representar “SxxExx” si tienes season/episodeNumber
    private var formattedEpisodeCode: String? {
        guard let s = season, let e = episodeNumber else { return nil }
        let ss = String(format: "S%02d", s)
        let ee = String(format: "E%02d", e)
        return "\(ss)\(ee)"
    }
    
    // Hashable
//    static func == (lhs: EpisodeResultsBO, rhs: EpisodeResultsBO) -> Bool {
//        lhs.id == rhs.id
//        && lhs.airdate == rhs.airdate
//        && lhs.episodeNumber == rhs.episodeNumber
//        && lhs.imagePath == rhs.imagePath
//        && lhs.name == rhs.name
//        && lhs.season == rhs.season
//        && lhs.synopsis == rhs.synopsis
//    }
//    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(id)
//    }
    
    // Decoding keys para URLs y snake_case
    enum CodingKeys: String, CodingKey {
        case id
        case airdate
        case episodeNumber = "episode_number"
        case imagePath = "image_path"
        case name
        case season
        case synopsis
    }
}
