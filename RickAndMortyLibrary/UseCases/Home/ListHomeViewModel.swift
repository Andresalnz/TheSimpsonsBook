//
//  ListCharactersViewModel.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 19/10/23.
//

import Foundation

final class ListHomeViewModel: ObservableObject {
    
    //MARK: - Variables
    private var loadListOnce: Bool = true
    
    //Interactor
    private let interactor: Interactor
    
    private var (pageCh, pageEp, pageLo) = (0, 0, 0)
    
    //MARK: - Published
    //Array que almacena la informacion
    @Published var characters: [SimpsonsCharacterBO]
    @Published var episodes: [SimpsonsEpisodeBO]
    @Published var locations: [SimpsonsLocationBO]
    @Published var viewState: ViewState = .loading
    let type: TypeViewList
    
    //Manejo de errores
    @Published var errorMsg = ""
    @Published var showAlert = false
    
    //MARK: - Init
    init(interactor: Interactor = SimpsonsInteractor(repository: Repository()), characters: [SimpsonsCharacterBO] = [], episodes: [SimpsonsEpisodeBO] = [], locations: [SimpsonsLocationBO] = [], type: TypeViewList) {
        self.interactor = interactor
        self.characters = characters
        self.episodes = episodes
        self.locations = locations
        self.type = type
    }
    
    var isLoading: Bool {
           viewState == .loading
       }
   
    //MARK: - Search
    
    // Variable que devuelve un array de personajes segun lo que se busque
    var searchCharacters: [SimpsonsCharacterBO] {
        guard !searchText.isEmpty else { return characters }
        return characters.filter { character in
            character.name!.lowercased().contains(searchText.lowercased())
        }
    }
    
    // Variable que devuelve un array de episodios segun lo que se busque
    var searchEpisodes: [SimpsonsEpisodeBO] {
        guard !searchText.isEmpty else { return episodes }
        return episodes.filter { episode in
            episode.name!.lowercased().contains(searchText.lowercased())
        }
    }
    
    //Variable que devuelve  un array de localizaciones segun lo que se busque
    var searchLocations: [SimpsonsLocationBO] {
        guard !searchText.isEmpty else { return locations }
        return locations.filter { location in
            location.name!.lowercased().contains(searchText.lowercased())
        }
    }
    
    //Propiedad que almacena el texto que se esta buscando
    @Published var searchText: String = ""
    

    //MARK: - Método para uso en la vista, para pintar todo lo necesario
    func loadUI(_ type: TypeViewList) {
        Task {
            try await loadData(type)
        }
        //loadListOnce = false
    }
    
    @MainActor
    func loadMoreIfNeeded() {
        Task {
            viewState = .loading
            try await Task.sleep(nanoseconds: 2_000_000_000)
            //try await loadData()
        }
    }
    
//    func checkTheLastIdCharacters(of: CharactersResultsBO) -> Bool {
//        return characters.last?.id == of.id
//    }
//    
//    func checkTheLastIdEpisodes(of: EpisodeResultsBO) -> Bool {
//        return episodes.last?.id == of.id
//    }
//    
//    func checkTheLastIdLocations(of: LocationResultsBO) -> Bool {
//        return locations.last?.id == of.id
//    }
//    
//    func stateLoadListOnce() -> Bool {
//        return loadListOnce
//    }
    
    //MARK: - Método que se ejecuta en el hilo principal, para realizar petición y cargar los primeros personajes
    func loadData(_ type: TypeViewList) async throws {
        switch type {
            case .characters:
            let getAllCharacters = try await interactor.getAllCharacters()
                await MainActor.run {
                    if let infoCharacters = getAllCharacters.characters {
                        let character = infoCharacters.compactMap({ $0.toBo() })
                        self.characters.append(contentsOf: character)
                    }
                    viewState = .finished
                }
            case .episodes:
                let getAllEpisodes = try await interactor.getAllEpisodes()
                    await MainActor.run {
                        if let infoEpisodes = getAllEpisodes.episodes {
                            let episode = infoEpisodes.compactMap({ $0.toBo() })
                            self.episodes.append(contentsOf: episode)
                        }
                        viewState = .finished
                    }
            case .locations:
                let getAllCharacters = try await interactor.getAllLocations()
                    await MainActor.run {
                        if let infoLocations = getAllCharacters.locations {
                            let location = infoLocations.compactMap({ $0.toBo() })
                            self.locations.append(contentsOf: location)
                        }
                        viewState = .finished
                    }
        }
        
    }
}

extension ListHomeViewModel {
    enum ViewState {
        case loading
        case finished
    }
}
