//
//  SimpsonsCharacterDetailBO.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 28/10/25.
//

import Foundation

// MARK: - Simpsons Character Detail BO
struct SimpsonsCharacterDetailBO: Codable, Identifiable, Hashable {
    let id: Int?
    let age: Int?
    let birthdate: String?
    let description: String?
    let firstAppearanceEpId: Int?
    let firstAppearanceShId: Int?
    let gender: SimpsonsCharacterGenderBO?
    let name: String?
    let occupation: String?
    let phrases: [String]?
    let portraitPath: URL?
    let status: String?
    let firstAppearanceEp: SimpsonsFirstAppearanceBO?
    let firstAppearanceSh: SimpsonsFirstAppearanceBO?
    
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

// MARK: - First Appearance (Episode/Short) BO
struct SimpsonsFirstAppearanceBO: Codable, Identifiable, Hashable {
    let id: Int?
    let airdate: String?
    let description: String?
    let episodeNumber: Int?
    let imagePath: URL?
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

