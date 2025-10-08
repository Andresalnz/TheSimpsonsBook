//
//  SimpsonsHomeInteractor.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 8/10/25.
//

import Foundation

extension Interactor {
    
    // Construye la URL
    func buildURL(_ type: TypeViewList) throws -> URL {
        guard let baseURL = baseURL,
              let baseComponents = URLComponents(string: baseURL.absoluteString) else {
            throw ErrorHandler.invalidUrl
        }
        
        var components = baseComponents
        components.path = type.rawValue
        
        guard let url = components.url else {
            throw ErrorHandler.invalidUrl
        }
        return url
    }
    
    // Helper genérico
     func fetch<T: Codable>(_ typeView: TypeViewList, as type: T.Type) async throws -> T {
        let url = try buildURL(typeView)
        
        return try await repository.getJSON(url: url, type: type)
    }
    
    func getAllCharacters() async throws -> SimpsonsCharactersPageDTO {
        return try await fetch(.characters, as: SimpsonsCharactersPageDTO.self)
    }
    
    func getAllEpisodes() async throws -> SimpsonsEpisodesPageDTO {
        return try await fetch(.episodes, as: SimpsonsEpisodesPageDTO.self)
    }
    
    func getAllLocations() async throws -> SimpsonsLocationsPageDTO {
        return try await fetch(.locations, as: SimpsonsLocationsPageDTO.self)
    }
}
