//
//  SimpsonsHomeInteractor.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 8/10/25.
//

import Foundation

extension Interactor {
    
    //MARK: - Construye la URL base según el tipo
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
    
    //MARK: - Helpers
    // Helper genérico por tipo base
    func fetch<T: Codable>(_ typeView: TypeViewList, as type: T.Type) async throws -> T {
        let url = try buildURL(typeView)
        return try await repository.getJSON(url: url, type: type)
    }
    
    //MARK: - Primera carga
    func getAllCharacters() async throws -> SimpsonsCharactersPageDTO {
        return try await fetch(.characters, as: SimpsonsCharactersPageDTO.self)
    }
    
    func getAllEpisodes() async throws -> SimpsonsEpisodesPageDTO {
        return try await fetch(.episodes, as: SimpsonsEpisodesPageDTO.self)
    }
    
    func getAllLocations() async throws -> SimpsonsLocationsPageDTO {
        return try await fetch(.locations, as: SimpsonsLocationsPageDTO.self)
    }
    
    //MARK: - Para cargar mas datos
    func getMoreCharacters(next: URL) async throws -> SimpsonsCharactersPageDTO {
        return try await repository.getJSON(url: next, type: SimpsonsCharactersPageDTO.self)
    }
    
    func getMoreEpisodes(next: URL) async throws -> SimpsonsEpisodesPageDTO {
        return try await repository.getJSON(url: next, type: SimpsonsEpisodesPageDTO.self)
    }
    
    func getMoreLocations(next: URL) async throws -> SimpsonsLocationsPageDTO {
        return try await repository.getJSON(url: next, type: SimpsonsLocationsPageDTO.self)
    }
}
