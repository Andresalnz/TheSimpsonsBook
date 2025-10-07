//
//  LocationModelBO.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 20/11/23.
//

import Foundation

struct SimpsonsLocationsPageBO: Codable, Hashable, Identifiable {
    let id: Int?
    let count: Int?
    let next: String?
    let prev: String?
    let pages: Int?
    let locations: [SimpsonsLocationBO]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case count
        case next
        case prev
        case pages
        case locations = "results"
    }
}


struct SimpsonsLocationBO: Codable, Hashable, Identifiable {
    let id: Int?
    let name: String?
    let imagePath: String?
    let dimension: String?
    let town: String?
    let use: String?
    
    var imageURL: URL? {
        guard let imagePath  else { return nil }
        return URL(string: "https://cdn.thesimpsonsapi.com/500\(imagePath)")
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imagePath = "image_path"
        case dimension
        case town
        case use
    }
}
