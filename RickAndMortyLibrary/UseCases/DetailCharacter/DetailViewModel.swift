//
//  DetailCharacterViewModel.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 19/10/23.
//

import Foundation

enum NumbersRows: Int, CaseIterable {
    case five = 5
    case ten = 10
    case all
}

final class DetailViewModel: ObservableObject {
    
    //MARK: - Variables
    
    private let interactor: OldInteractor
    
    //Propiedad que almacena las URL de los episodios del personaje elegido
   
    let type: TypeViewList
    
    var currentIndex = 0
    //MARK: - Published
    
    //Propidedad que almacena todos los episodios
    
    @Published var allCharacters: [SimpsonsCharactersPageBO]
    
    //Manejo de errores
    @Published var errorMsg = ""
    @Published var showAlert = false
    
    //Propiedad que almacena un solo episodio
   
    var character: SimpsonsCharactersPageBO?
    var nextLimit: Int = 5
    //MARK: - Init
    init(interactor: OldInteractor = OldInteractor.shared, type: TypeViewList, allCharacters: [SimpsonsCharactersPageBO] = [], character: SimpsonsCharactersPageBO? = nil) {
        self.interactor = interactor
        
        self.type = type
      
        self.allCharacters = allCharacters
        
        self.character = character
       
    }
    
    //MARK: - Método para uso en la vista, para pintar todo lo necesario
//    func loadUI() {
//        Task {
//            try await loadData()
//        }
//    }
    
    func loadSave(infoFavourite: Detail) {
        Task {
            try await saveFavourite(infoFavourite: infoFavourite)
        }
    }
    
    func saveFavourite(infoFavourite: Detail) async throws {
        switch type {
            case .characters:
                try await interactor.createFavouriteCharacter(model: infoFavourite)
            case .locations:
                try await interactor.createFavouriteLocation(model: infoFavourite)
            case .episodes:
                try await interactor.createFavouriteEpisode(model: infoFavourite)
        }
    }
    
  
//    //MARK: - Método que se ejecuta en el hilo principal, para guardar todos los datos
//    func loadData() async throws {
//        do {
//            switch type {
//                case .characters:
//                    for urlEpisodeOrCharacter in currentIndex..<allEpisodeCharacter.count  {
//                        let singleEpisode = try await interactor.singleEpisode(url: allEpisodeCharacter[urlEpisodeOrCharacter])
//                        await MainActor.run {
//                            self.episode = singleEpisode.toBo()
//                            if let episode = episode {
//                                if nextLimit > allEpisodes.count {
//                                    allEpisodes.append(episode)
//                                    currentIndex = nextLimit
//                                }
//                            }
//                        }
//                    }
//                case .episodes, .locations:
//                    for urlEpisodeOrCharacter in currentIndex..<allEpisodeCharacter.count  {
//                        let singleCharacter = try await interactor.singleCharacter(url: allEpisodeCharacter[urlEpisodeOrCharacter])
//                        await MainActor.run {
//                            self.character = singleCharacter.toBo()
//                            if let character = character {
//                                if nextLimit > allCharacters.count {
//                                    allCharacters.append(character)
//                                    currentIndex = nextLimit
//                                }
//                            }
//                        }
//                    }
//            }
//        } catch {
//            await MainActor.run {
//                guard let errorDescription = ErrorHandler.requestNotWork.errorDescription else { return }
//                errorMsg = errorDescription
//                showAlert.toggle()
//            }
//        }
//    }
}
