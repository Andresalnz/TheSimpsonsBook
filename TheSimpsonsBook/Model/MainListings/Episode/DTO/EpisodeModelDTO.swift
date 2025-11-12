//
//  EpisodeModelDTO.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 20/10/23.
//

import Foundation

// MARK: - Simpsons Episodes DTOs

struct SimpsonsEpisodesPageDTO: Codable, Hashable, Identifiable {
    let id: Int?
    let count: Int?
    let next: String?
    let prev: String?
    let pages: Int?
    let episodes: [SimpsonsEpisodeDTO]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case count
        case next
        case prev
        case pages
        case episodes = "results"
    }
}

struct SimpsonsEpisodeDTO: Codable, Identifiable, Hashable {
    let id: UUID = UUID()
    
    let episodeId: Int?
    let airdate: String?
    let episodeNumber: Int?
    let imagePath: String?
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

/*
 {
   "count": 768,
   "next": "https://thesimpsonsapi.com/api/episodes?page=2",
   "prev": null,
   "pages": 39,
   "results": [
     {
       "id": 1,
       "airdate": "1989-12-17",
       "episode_number": 1,
       "image_path": "/episode/1.webp",
       "name": "Simpsons Roasting on an Open Fire",
       "season": 1,
       "synopsis": "..."
     }
   ]
 }
 */
