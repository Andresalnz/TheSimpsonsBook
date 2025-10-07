//
//  RMFirebaseFirestore.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 15/2/24.
//

import Foundation
import FirebaseFirestore

struct RMFirebaseFirestoreSaveDocuments {
    private let database = Firestore.firestore()
    
    //MARK: - Crear colecciones
    //Personajes
    func createFavsCharacters(model: Detail, collection: String) async throws {
        do {
            let character: [String: Any] = [
                "name": model.name ?? "",
                "status": model.status?.rawValue ?? "",
               
                "type": model.type ?? "",
                "gender": model.gender?.rawValue ?? "",
                "origin": model.origin?.name ?? "",
                "location": model.location?.name ?? "",
                "image": model.image?.description ?? ""
            ]
            
            try await database.collection(collection).addDocument(data: character)
        } catch {
            throw ErrorHandler.FirestoreNotSaveDocument
        }
    }
    
    //Episodios
    func createFavsEpisodes(model: Detail, collection: String) async throws {
        
        let episode: [String: Any] = [
            "name": model.name ?? "",
            "airDate": model.airDate ?? "",
           
        ]
        
        do {
            try await database.collection(collection).addDocument(data: episode)
        } catch {
            throw ErrorHandler.FirestoreNotSaveDocument
        }
    }
    
    //Localizaciones
    func createFavsLocations(model: Detail, collection: String) async throws {
        let location: [String: Any] = [
            "name": model.name ?? "",
            "type": model.type ?? "",
            "dimension": model.dimension ?? "",
        ]
        
        do {
            try await database.collection(collection).addDocument(data: location)
        } catch {
            throw ErrorHandler.FirestoreNotSaveDocument
        }
    }
}
