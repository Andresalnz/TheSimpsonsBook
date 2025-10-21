//
//  ListCharactersViewModel.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 19/10/23.
//

import Foundation

enum LoadMode {
    case initial
    case nextPage
}

final class ListHomeViewModel: ObservableObject {
    
    //MARK: - Variables
    //Interactor
    private let interactor: Interactor
    
    // URL "next" por tipo para paginación
    private var nextCharactersURL: URL?
    private var nextEpisodesURL: URL?
    private var nextLocationsURL: URL?
    
    //MARK: - Published
    @Published var characters: [SimpsonsCharacterBO]
    @Published var episodes: [SimpsonsEpisodeBO]
    @Published var locations: [SimpsonsLocationBO]
    @Published var viewState: ViewState = .loading
    let type: TypeViewList
    
    //Manejo de errores
    @Published var errorMsg = ""
    @Published var showAlert = false
    
    // Búsqueda
    @Published var searchText: String = ""
    
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
    var searchCharacters: [SimpsonsCharacterBO] {
        guard !searchText.isEmpty else { return characters }
        return characters.filter { character in
            character.name?.lowercased().contains(searchText.lowercased()) == true
        }
    }
    
    var searchEpisodes: [SimpsonsEpisodeBO] {
        guard !searchText.isEmpty else { return episodes }
        return episodes.filter { episode in
            episode.name?.lowercased().contains(searchText.lowercased()) == true
        }
    }
    
    var searchLocations: [SimpsonsLocationBO] {
        guard !searchText.isEmpty else { return locations }
        return locations.filter { location in
            location.name?.lowercased().contains(searchText.lowercased()) == true
        }
    }
    
    //MARK: - checkTheLastIdCharacters
    func checkTheLastIdCharacters(_ type: TypeViewList, of: UUID) -> Bool {
        switch type {
            case .characters:
                return characters.last?.id == of
            case .episodes:
                return episodes.last?.id == of
            case .locations:
                return locations.last?.id == of
        }
    }
    
    //MARK: - load
    func load(_ type: TypeViewList, mode: LoadMode) async {
        do {
            await MainActor.run { viewState = .loading }
            try await Task.sleep(nanoseconds: 2_000_000_000)
            switch type {
                case .characters:
                    
                    try await loadCharacters(mode: mode)
                case .episodes:
                    try await loadEpisodes(mode: mode)
                case .locations:
                    try await loadLocations(mode: mode)
            }
        } catch let err {
            print(err.localizedDescription)
        }
        
    }
    
    //MARK: - loadCharacters
    private func loadCharacters(mode: LoadMode) async throws {
        switch mode {
            case .initial:
                let page = try await interactor.getAllCharacters()
                await MainActor.run {
                    if let info = page.characters {
                        let mapped = info.compactMap { $0.toBo() }
                        self.characters.append(contentsOf: mapped)
                    }
                    if let nextStr = page.next, let url = URL(string: nextStr) {
                        self.nextCharactersURL = url
                    } else {
                        self.nextCharactersURL = nil
                    }
                    viewState = .finished
                }
                
            case .nextPage:
                guard let next = nextCharactersURL else { return }
                let page = try await interactor.getMoreCharacters(next: next)
                await MainActor.run {
                    if let info = page.characters {
                        let mapped = info.compactMap { $0.toBo() }
                        self.characters.append(contentsOf: mapped)
                    }
                    if let nextStr = page.next, let url = URL(string: nextStr) {
                        self.nextCharactersURL = url
                    } else {
                        self.nextCharactersURL = nil
                    }
                }
                await MainActor.run { viewState = .finished }
        }
    }
    
    //MARK: - loadEpisodes
    private func loadEpisodes(mode: LoadMode) async throws {
        switch mode {
            case .initial:
                let page = try await interactor.getAllEpisodes()
                await MainActor.run {
                    if let info = page.episodes {
                        let mapped = info.compactMap { $0.toBo() }
                        self.episodes.append(contentsOf: mapped)
                    }
                    if let nextStr = page.next, let url = URL(string: nextStr) {
                        self.nextEpisodesURL = url
                    } else {
                        self.nextEpisodesURL = nil
                    }
                    self.viewState = .finished
                }
                
            case .nextPage:
                guard let next = nextEpisodesURL else { return }
                let page = try await interactor.getMoreEpisodes(next: next)
                await MainActor.run {
                    if let info = page.episodes {
                        let mapped = info.compactMap { $0.toBo() }
                        self.episodes.append(contentsOf: mapped)
                    }
                    if let nextStr = page.next, let url = URL(string: nextStr) {
                        self.nextEpisodesURL = url
                    } else {
                        self.nextEpisodesURL = nil
                    }
                }
        }
    }
    
    //MARK: - loadLocations
    private func loadLocations(mode: LoadMode) async throws {
        switch mode {
            case .initial:
                let page = try await interactor.getAllLocations()
                await MainActor.run {
                    if let info = page.locations {
                        let mapped = info.compactMap { $0.toBo() }
                        self.locations.append(contentsOf: mapped)
                    }
                    if let nextStr = page.next, let url = URL(string: nextStr) {
                        self.nextLocationsURL = url
                    } else {
                        self.nextLocationsURL = nil
                    }
                    self.viewState = .finished
                }
                
            case .nextPage:
                guard let next = nextLocationsURL else { return }
                let page = try await interactor.getMoreLocations(next: next)
                await MainActor.run {
                    if let info = page.locations {
                        let mapped = info.compactMap { $0.toBo() }
                        self.locations.append(contentsOf: mapped)
                    }
                    if let nextStr = page.next, let url = URL(string: nextStr) {
                        self.nextLocationsURL = url
                    } else {
                        self.nextLocationsURL = nil
                    }
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
