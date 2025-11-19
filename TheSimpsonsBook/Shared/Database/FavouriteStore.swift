//
//  FavouriteStore.swift
//  TheSimpsonsBook
//
//  Created by Andres Aleu on 18/11/25.
//

import Foundation
import SwiftData

//MARK: - Operaciones para marcar favoritos con SwiftData
actor FavouriteStore {

    private let context: ModelContext

    init(context: ModelContext) {
        self.context = context
    }

    // Comprueba si existe un favorito por (type, remoteId)
    func isFavorite(type: FavouriteType, remoteId: Int) throws -> Bool {
        try fetchOne(type: type, remoteId: remoteId) != nil
    }

    // Inserta un favorito si no existe
    func add(_ data: FavouriteModel) throws {
        if try fetchOne(type: data.type, remoteId: data.remoteId) != nil {
            // Ya existe, no hacemos nada
            return
        }
        context.insert(data)
    }

    // Elimina un favorito si existe
    func remove(type: FavouriteType, remoteId: Int) throws {
        if let existing = try fetchOne(type: type, remoteId: remoteId) {
            context.delete(existing)
        }
    }

    // Alterna el estado de favorito. Devuelve true si queda marcado como favorito.
    @discardableResult
    func toggle(_ data: FavouriteModel) throws -> Bool {
        if let existing = try fetchOne(type: data.type, remoteId: data.remoteId) {
            context.delete(existing)
           
            return false
        } else {
            context.insert(data)
            
            return true
        }
    }

    // Obtiene todos los favoritos, opcionalmente filtrados por tipo, ordenados por fecha de creación desc.
    func fetchAll(type: FavouriteType? = nil) throws -> [FavouriteModel] {
        var descriptor: FetchDescriptor<FavouriteModel>
        if let type {
            descriptor = FetchDescriptor<FavouriteModel>(
                predicate: #Predicate { $0.type == type },
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

    // Recupera un único favorito por clave lógica (type, remoteId)
    private func fetchOne(type: FavouriteType, remoteId: Int) throws -> FavouriteModel? {
        let descriptor = FetchDescriptor<FavouriteModel>(
            predicate: #Predicate { $0.type == type && $0.remoteId == remoteId },
            sortBy: []
        )
        return try context.fetch(descriptor).first
    }
}
