//
//  DetailViewProtocols.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 21/11/23.
//

import Foundation

protocol DetailCharacter: Encodable {
    var image: URL? { get }
    var status: SimpsonsCharacterStatusBO? { get }
    var gender: SimpsonsCharacterGenderBO? { get }
    var origin: LocationOriginBO? { get }
    var location: LocationOriginBO? { get }
    var episodes: [URL]? { get }
}

protocol DetailEpisode: Encodable {
    var airDate: String? { get }

    var characters: [URL]? { get }
}

protocol DetailLocation: Encodable {
    var type: String? { get }
    var dimension: String? { get }
    var residents: [URL]? { get }
}

protocol Detail: DetailCharacter, DetailEpisode, DetailLocation, Encodable {
    var name: String? { get }
}
