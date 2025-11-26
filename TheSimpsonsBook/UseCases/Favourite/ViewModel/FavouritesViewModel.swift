//
//  FavouriteViewModel.swift
//  TheSimpsonsBook
//
//  Created by Andres Aleu on 19/11/25.
//

import Foundation

@MainActor
final class FavouritesViewModel: ObservableObject {
    
    private let databaseLocal: FavouriteStoreProtocol
    
    init(databaseLocal: FavouriteStoreProtocol) {
        self.databaseLocal = databaseLocal
    }
    
    func onDelete(in favourites: FavouriteModel) throws {
        try databaseLocal.remove(type: favourites.type, remoteId: favourites.remoteId)
    }
}
