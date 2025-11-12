//
//  SimpsonsLocationBO.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 28/10/25.
//

import Foundation

// MARK: - Simpsons Location Detail BO
struct SimpsonsLocationDetailBO: Codable, Identifiable, Hashable {
    let id: UUID = UUID()
    
    let locationDetailId: Int?
    let description: String?
    let firstAppearanceEpId: Int?
    let firstAppearanceShId: Int?
    let imagePath: URL?
    let name: String?
    let town: String?
    let use: String?
    let firstAppearanceSh: SimpsonsFirstAppearanceLocationBO?
    let firstAppearanceEp: SimpsonsFirstAppearanceLocationBO?
    
    enum CodingKeys: String, CodingKey {
        case locationDetailId = "id"
        case description
        case firstAppearanceEpId = "first_appearance_ep_id"
        case firstAppearanceShId = "first_appearance_sh_id"
        case name
        case imagePath = "image_path"
        case town
        case use
        case firstAppearanceEp = "first_appearance_ep"
        case firstAppearanceSh = "first_appearance_sh"
    }
}


// MARK: - First Appearance (Episode/Short) DTO
struct SimpsonsFirstAppearanceLocationBO: Codable, Identifiable, Hashable {
    let id: UUID = UUID()
    
    let firstAppearanceId: Int?
    let airdate: String?
    let description: String?
    let episodeNumber: Int?
    let imagePath: URL?
    let name: String?
    let season: Int?
    let synopsis: String?
    
    enum CodingKeys: String, CodingKey {
        case firstAppearanceId = "id"
        case airdate
        case description
        case episodeNumber = "episode_number"
        case imagePath = "image_path"
        case name
        case season
        case synopsis
    }
}
