//
//  SimpsonsInteractorProtocol.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 8/10/25.
//

import Foundation

protocol Interactor {
    var repository: Repository { get }
    var baseURL: URL? { get }
}

struct SimpsonsInteractor: Interactor {
    var repository: Repository
    
    var baseURL: URL? {
        URL(string: "https://thesimpsonsapi.com/")
    }
}
