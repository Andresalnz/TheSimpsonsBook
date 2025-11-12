//
//  LocationModelDTO.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 20/11/23.
//

import Foundation

struct SimpsonsLocationsPageDTO: Codable, Hashable, Identifiable {
    let id: Int?
    let count: Int?
    let next: String?
    let prev: String?
    let pages: Int?
    let locations: [SimpsonsLocationDTO]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case count
        case next
        case prev
        case pages
        case locations = "results"
    }
}


struct SimpsonsLocationDTO: Codable, Hashable, Identifiable {
    let id: UUID = UUID()
    
    let locationId: Int?
    let name: String?
    let imagePath: String?
    let dimension: String?
    let town: String?
    let use: String?
    
    enum CodingKeys: String, CodingKey {
        case locationId = "id"
        case name
        case imagePath = "image_path"
        case dimension
        case town
        case use
    }
}

/*
 {
   "count": 477,
   "next": "https://thesimpsonsapi.com/api/locations?page=2",
   "prev": null,
   "pages": 24,
   "results": [
     {
       "id": 1,
       "name": "742 Evergreen Terrace",
       "image_path": "/location/1.webp",
       "town": "Springfield",
       "use": "Residential"
     }
   ]
 }
 */
