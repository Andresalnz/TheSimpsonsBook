//
//  SimpsonsInteractorProtocol.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 8/10/25.
//

import Foundation

protocol Interactor: Sendable {
    var repository: Repository { get }
    var baseURL: URL? { get }
}

struct SimpsonsInteractor: Interactor {
    let repository: Repository
    
    var baseURL: URL? {
        URL(string: "https://thesimpsonsapi.com/")
    }
}
