//
//  SimpsonsCharacterDetailDTO.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 28/10/25.
//

import Foundation

// MARK: - Simpsons Character Detail DTO
struct SimpsonsCharacterDetailDTO: Codable, Identifiable, Hashable {
    let id: Int?
    let age: Int?
    let birthdate: String?
    let description: String?
    let firstAppearanceEpId: Int?
    let firstAppearanceShId: Int?
    let gender: String?
    let name: String?
    let occupation: String?
    let phrases: [String]?
    let portraitPath: String?
    let status: String?
    let firstAppearanceEp: SimpsonsFirstAppearanceDTO?
    let firstAppearanceSh: SimpsonsFirstAppearanceDTO?
    
    enum CodingKeys: String, CodingKey {
        case id
        case age
        case birthdate
        case description
        case firstAppearanceEpId = "first_appearance_ep_id"
        case firstAppearanceShId = "first_appearance_sh_id"
        case gender
        case name
        case occupation
        case phrases
        case portraitPath = "portrait_path"
        case status
        case firstAppearanceEp = "first_appearance_ep"
        case firstAppearanceSh = "first_appearance_sh"
    }
}

// MARK: - First Appearance (Episode/Short) DTO
struct SimpsonsFirstAppearanceDTO: Codable, Identifiable, Hashable {
    let id: Int?
    let airdate: String?
    let description: String?
    let episodeNumber: Int?
    let imagePath: String?
    let name: String?
    let season: Int?
    let synopsis: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case airdate
        case description
        case episodeNumber = "episode_number"
        case imagePath = "image_path"
        case name
        case season
        case synopsis
    }
}
