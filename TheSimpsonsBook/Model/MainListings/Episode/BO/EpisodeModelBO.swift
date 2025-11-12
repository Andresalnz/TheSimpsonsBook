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
    let id: UUID = UUID()
    
    let episodeId: Int?
    let airdate: String?
    let episodeNumber: Int?
    let imagePath: URL?
    let name: String?
    let season: Int?
    let synopsis: String?
   
    
    enum CodingKeys: String, CodingKey {
        case episodeId = "id"
        case airdate
        case episodeNumber = "episode_number"
        case imagePath = "image_path"
        case name
        case season
        case synopsis
    }
}
