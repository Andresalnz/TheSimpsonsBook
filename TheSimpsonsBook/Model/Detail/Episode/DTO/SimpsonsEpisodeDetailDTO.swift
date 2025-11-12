//
//  SimpsonsEpisodeDetailDTO.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 28/10/25.
//

import Foundation

// MARK: - Simpsons Episode Detail DTO
struct SimpsonsEpisodeDetailDTO: Codable, Identifiable, Hashable {
    let id: UUID = UUID()
    
    let episodeDetailId: Int?
    let airdate: String?
    let description: String?
    let episodeNumber: Int?
    let imagePath: String?
    let name: String?
    let season: Int?
    let synopsis: String?
    
    enum CodingKeys: String, CodingKey {
        case episodeDetailId = "id"
        case airdate
        case description
        case episodeNumber = "episode_number"
        case imagePath = "image_path"
        case name
        case season
        case synopsis
    }
}
