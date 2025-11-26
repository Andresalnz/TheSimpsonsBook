//
//  FavouriteStore.swift
//  TheSimpsonsBook
//
//  Created by Andres Aleu on 18/11/25.
//

import Foundation
import SwiftData

protocol FavouriteStoreProtocol {
    @MainActor func add(type: FavouriteType, remoteId: Int?, title: String?, subtitle: String?, imageURL: URL?, createdAt: Date)  throws
    @MainActor func remove(type: FavouriteType, remoteId: Int?)  throws
    @MainActor func isFavorite(type: FavouriteType, remoteId: Int?)  throws -> Bool
}

//MARK: - Operaciones para marcar favoritos con SwiftData
@MainActor
class FavouriteStore: FavouriteStoreProtocol {

    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    func isFavorite(type: FavouriteType, remoteId: Int?)  throws -> Bool {
        if  try fetchOne(type: type, remoteId: remoteId) != nil { return true }
        return false
    }

    func add(type: FavouriteType, remoteId: Int?, title: String?, subtitle: String?, imageURL: URL?, createdAt: Date) throws {
        
        if try fetchOne(type: type, remoteId: remoteId) != nil {
            return
        }
        guard let remoteId = remoteId else { return }
        let model = FavouriteModel(type: type, remoteId: remoteId, title: title, subtitle: subtitle, imageURL: imageURL, createdAt: createdAt)
        context.insert(model)
        try context.save()
    }

    func remove(type: FavouriteType, remoteId: Int?) throws {
        if let existing = try fetchOne(type: type, remoteId: remoteId) {
            context.delete(existing)
            try context.save()
        }
    }
    
    // Obtiene todos los favoritos, opcionalmente filtrados por tipo, ordenados por fecha de creación desc.
    func fetchAll(type: FavouriteType?) throws -> [FavouriteModel] {
        var descriptor: FetchDescriptor<FavouriteModel>
        if let type {
            descriptor = FetchDescriptor<FavouriteModel>(
                predicate: #Predicate { $0.typeRaw == type.rawValue },
                sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
            )
        } else {
            descriptor = FetchDescriptor<FavouriteModel>(
                sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
            )
        }
        return try context.fetch(descriptor)
    }

    // MARK: - Private
    private func fetchOne(type: FavouriteType, remoteId: Int?) throws -> FavouriteModel? {
        let descriptor: FetchDescriptor<FavouriteModel>
        if let remoteId {
            descriptor = FetchDescriptor<FavouriteModel>(
                predicate: #Predicate { $0.typeRaw == type.rawValue && $0.remoteId == remoteId },
                sortBy: []
            )
            
            return try context.fetch(descriptor).first
        }
        return nil
    }
}
