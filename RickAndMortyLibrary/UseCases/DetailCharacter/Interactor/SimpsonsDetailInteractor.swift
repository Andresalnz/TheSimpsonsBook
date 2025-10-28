//
//  SimpsonsDetailInteractor.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 28/10/25.
//

import Foundation

extension Interactor {
    //MARK: - Construye URL según el tipo
    func buildURL(_ type: TypeViewList, _ id: Int) throws -> URL {
        guard let baseURL = baseURL,
              let baseComponents = URLComponents(string: baseURL.absoluteString) else {
            throw ErrorHandler.invalidUrl
        }
        
        var components = baseComponents
        components.path = type.rawValue
        components.path += "/\(id)"
        
        guard let url = components.url else {
            throw ErrorHandler.invalidUrl
        }
        
        return url
        
    }
    
    //MARK: - Helpers
    // Helper genérico por tipo base
    func fetchDetail<T: Codable>(_ typeView: TypeViewList, as type: T.Type , _ id: Int) async throws -> T {
        let url = try buildURL(typeView, id)
        return try await repository.getJSON(url: url, type: type)
    }
    
    //MARK: - Detalle
    func getCharacterDetail(id: Int) async throws -> SimpsonsCharacterDetailDTO {
        return try await fetchDetail(.characters, as: SimpsonsCharacterDetailDTO.self, id)
    }
}
