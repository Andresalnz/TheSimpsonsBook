//
//  DetailModelVO.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 21/11/23.
//

import Foundation
import FirebaseFirestore


struct RowDetail: Codable, Hashable, Identifiable, Detail {
    @DocumentID var id: String?
    var airDate: String?
    var episode: String?
    var characters: [URL]?
    var dimension: String?
    var residents: [URL]?
    var type: String?
    var status: SimpsonsCharacterStatusBO?
    var gender: SimpsonsCharacterGenderBO?
    var origin: LocationOriginBO?
    var location: LocationOriginBO?
    var episodes: [URL]?
    var image: URL?
    var name: String?
}
