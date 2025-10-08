//
//  FavouritesViewModel.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 31/1/24.
//

import Foundation

final class FavouritesViewModel: ObservableObject {
    
    //MARK: - Variables
    
    //@Publised
    @Published var characters: [FirebaseFirestoreCharacterModel] = []
    @Published var episodes: [FirebaseFirestoreEpisodeLocationModel] = []
    @Published var locations: [FirebaseFirestoreEpisodeLocationModel] = []
    @Published var typeList: TypeViewList
    
    //interactor
    private let interactor: OldInteractor
    
    //MARK: - Init
    init(interactor: OldInteractor = OldInteractor.shared, typeList: TypeViewList) {
        self.interactor = interactor
        self.typeList = typeList
    }
    
    //MARK: - loadUI
    func loadUI() {
        Task {
         try  await loadData()
        }
    }
    
    func loadDelete(collection: String, id: String?) {
        Task {
            if let id = id {
                try await actionDelete(collection: collection, id: id)                
            }
        
        }
        loadUI()
    }
    func actionDelete(collection: String, id: String?) async throws {
        if let id = id {
            try await interactor.delete(collection: collection, id: id)
        }
    }
    
    //MARK: - loadData
    func loadData() async throws {
        switch typeList {
            case .characters:
                let getFavouritesCharacters = try await interactor.getAllDocumentsFavouritesCharacters(collection: Constants.collectionCharacter)
                await MainActor.run {
                    self.characters = getFavouritesCharacters
                }
            case .locations:
                let getFavouritesLocations = try await interactor.getAllDocumentsFavouritesEpisodes(collection: Constants.collectionLocations)
                await MainActor.run {
                    self.locations = getFavouritesLocations
                }
            case .episodes:
                let getFavouritesEpisodes = try await interactor.getAllDocumentsFavouritesEpisodes(collection: Constants.collectionEpisodes)
                await MainActor.run {
                    self.episodes = getFavouritesEpisodes
                }
        }
    }
}
