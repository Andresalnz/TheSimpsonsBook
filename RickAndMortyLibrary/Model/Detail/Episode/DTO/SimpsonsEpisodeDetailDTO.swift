//
//  SimpsonsEpisodeDetailDTO.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 28/10/25.
//

import Foundation

// MARK: - Simpsons Episode Detail DTO
struct SimpsonsEpisodeDetailDTO: Codable, Identifiable, Hashable {
    let id: Int?
    let airdate: String?
    let episodeNumber: Int?
    let imagePath: String?
    let name: String?
    let season: Int?
    let synopsis: String?
    
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
