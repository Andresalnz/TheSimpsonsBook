//
//  FavouriteModel.swift
//  TheSimpsonsBook
//
//  Created by Andres Aleu on 18/11/25.
//

import Foundation
import SwiftData

enum FavouriteType: String, Codable, CaseIterable, Identifiable {
    case character
    case episode
    case location
    
    var id: String { rawValue }
    
    var title: String {
        switch self {
            case .character: return "character"
            case .episode: return "Episodes"
            case .location: return "Locations"
        }
    }
}

@Model
final class FavouriteModel {
    
    //var type: FavouriteType
    var typeRaw: String = FavouriteType.character.rawValue
    @Transient // Le decimos a SwiftData que NO guarde esto, ya guardamos typeRaw
        var type: FavouriteType {
            get { FavouriteType(rawValue: typeRaw) ?? .character }
            set { typeRaw = newValue.rawValue }
        }
    
    var remoteId: Int

    var title: String?
    var subtitle: String?
    var imageURL: URL?

    var createdAt: Date

    init(type: FavouriteType, remoteId: Int, title: String? = nil, subtitle: String? = nil, imageURL: URL? = nil, createdAt: Date) {
        self.typeRaw = type.rawValue
        self.remoteId = remoteId
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
        self.createdAt = createdAt
    }
}

extension FavouriteModel {
   @MainActor static let sampleData = [
        FavouriteModel(type: .character, remoteId: 1,title: "character", subtitle: "subtitle", imageURL: URL(string: "https://cdn.thesimpsonsapi.com/500/character/1.webp"), createdAt: .now),
        FavouriteModel(type: .character, remoteId: 2,title: "character", subtitle: "subtitle", imageURL: URL(string: "https://cdn.thesimpsonsapi.com/500/character/1.webp"), createdAt: .now),
        FavouriteModel(type: .episode, remoteId: 3,title: "episode", subtitle: "subtitle", imageURL: URL(string: "https://cdn.thesimpsonsapi.com/500/character/1.webp"), createdAt: .now),
        FavouriteModel(type: .location, remoteId: 4,title: "location", subtitle: "subtitle", imageURL: URL(string: "https://cdn.thesimpsonsapi.com/500/character/1.webp"), createdAt: .now)
    ]
}
