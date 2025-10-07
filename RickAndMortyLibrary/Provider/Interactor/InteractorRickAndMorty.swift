//
//  InteractorCharacter.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 15/11/23.
//

import Foundation
import FirebaseFirestore

protocol RickAndMortyInteractor {
    func getAllCharacters(_ page: Int) async throws -> SimpsonsCharactersPageDTO
    func getAllEpisodes(_ page: Int) async throws -> SimpsonsEpisodesPageDTO
    func getAllLocations(_ page: Int) async throws -> LocationModelDTO
    func singleCharacter(url: URL?) async throws -> SimpsonsCharactersPageDTO
    func singleEpisode(url: URL?) async throws -> SimpsonsEpisodesPageDTO
}

struct Interactor: RickAndMortyInteractor {
    
    var repository: Repository
    var firebaseFirestoreSaveDocuments: RMFirebaseFirestoreSaveDocuments
    var firebaseFirestoreGetDocument: RMFirebaseFirestoreGetDocuments
    var firebaseFirestoreDeleteDocument: RMFirebaseFirestoreDeleteDocuments
    
    static let shared: Interactor = Interactor(repository: Repository(), firebaseFirestoreSaveDocuments: RMFirebaseFirestoreSaveDocuments(), firebaseFirestoreGetDocument: RMFirebaseFirestoreGetDocuments(), firebaseFirestoreDeleteDocument: RMFirebaseFirestoreDeleteDocuments())
    
    //MARK: - Characters
    
    //allCharacters
    func getAllCharacters(_ page: Int) async throws -> SimpsonsCharactersPageDTO {
        return try await repository.getJSON(url: Util.Services.allCharacters.shapeURL(page), type: SimpsonsCharactersPageDTO.self)
    }
    
    //singleCharacter
    func singleCharacter(url: URL?) async throws -> SimpsonsCharactersPageDTO {
        return try await repository.getJSON(url: url, type: SimpsonsCharactersPageDTO.self)
    }
    
    //MARK: - Episodes
    
    //allEpisodes
    func getAllEpisodes(_ page: Int) async throws -> SimpsonsEpisodesPageDTO {
        return try await repository.getJSON(url: Util.Services.allEpisodes.shapeURL(page), type: SimpsonsEpisodesPageDTO.self)
    }
    
    
    //singleEpisode
    func singleEpisode(url: URL?) async throws -> SimpsonsEpisodesPageDTO {
        return try await repository.getJSON(url: url, type: SimpsonsEpisodesPageDTO.self)
    }
    

    
    //MARK: - Location
    
    //allLocations
    func getAllLocations(_ page: Int) async throws -> LocationModelDTO {
        return try await repository.getJSON(url: Util.Services.allLocations.shapeURL(page), type: LocationModelDTO.self)
    }
    
    //MARK: - Firebase
    //Obtener documentos de favoritod de personajes
    func getAllDocumentsFavouritesCharacters(collection: String) async throws -> [FirebaseFirestoreCharacterModel] {
        return try await firebaseFirestoreGetDocument.getDocuments(collection: collection, type: FirebaseFirestoreCharacterModel.self)
    }
    //Obtener documentos de favoritos de localizaciones y episodios
    func getAllDocumentsFavouritesEpisodes(collection: String) async throws -> [FirebaseFirestoreEpisodeLocationModel] {
        return try await firebaseFirestoreGetDocument.getDocuments(collection: collection, type: FirebaseFirestoreEpisodeLocationModel.self)
    }
    
    func delete(collection: String, id: String) async throws {
        try await firebaseFirestoreDeleteDocument.delete(collection: collection, id: id)
    }
    
    
    //Guardar documento como favorito
    func createFavouriteCharacter(model: Detail) async throws {
        try await firebaseFirestoreSaveDocuments.createFavsCharacters(model: model, collection: Constants.collectionCharacter)
    }
    
    func createFavouriteEpisode(model: Detail) async throws {
        try await firebaseFirestoreSaveDocuments.createFavsEpisodes(model: model, collection: Constants.collectionEpisodes)
    }
    
    func createFavouriteLocation(model: Detail) async throws {
        try await firebaseFirestoreSaveDocuments.createFavsLocations(model: model, collection: Constants.collectionLocations)
    }
    
}
