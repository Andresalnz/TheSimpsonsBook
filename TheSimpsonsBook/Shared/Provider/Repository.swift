//
//  CharacterRepository.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 15/11/23.
//

import Foundation

struct Repository: Sendable {
    func getJSON<T>(url: URL, type: T.Type) async throws -> T where T: Codable {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(type, from: data)
            return decoded
        } catch {
            throw ErrorHandler.requestInvalid
        }
    }
}
