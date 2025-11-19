//
//  FavouriteModel.swift
//  TheSimpsonsBook
//
//  Created by Andres Aleu on 18/11/25.
//

import Foundation
import SwiftData


enum FavouriteType: String, Codable, CaseIterable, Sendable {
    case character
    case episode
    case location
}

@Model
final class FavouriteModel {
    
    var type: FavouriteType
    var remoteId: Int

    
    var title: String?
    var subtitle: String?
    var imageURL: URL?

    var createdAt: Date

    init(type: FavouriteType, remoteId: Int, title: String? = nil, subtitle: String? = nil, imageURL: URL? = nil, createdAt: Date) {
        self.type = type
        self.remoteId = remoteId
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
        self.createdAt = createdAt
    }
}

extension FavouriteModel {
   @MainActor static let sampleData = [
        FavouriteModel(type: .character, remoteId: 1, createdAt: .now),
        FavouriteModel(type: .character, remoteId: 1, createdAt: .now),
        FavouriteModel(type: .character, remoteId: 1, createdAt: .now),
        FavouriteModel(type: .character, remoteId: 1, createdAt: .now)
        
    ]
}
