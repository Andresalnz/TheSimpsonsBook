//
//  CharacterRepository.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 15/11/23.
//

import Foundation

struct Repository {
    
    func getJSON<T>(url: URL, type: T.Type) async throws -> T where T: Codable {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let rickAndMortyModel = try JSONDecoder().decode(type, from: data)
            return rickAndMortyModel
        } catch {
            throw ErrorHandler.requestInvalid
        }
    }
}
