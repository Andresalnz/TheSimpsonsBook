//
//  DetailCharacterViewModel.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 28/10/25.
//

import Foundation

struct AlertInfo: Identifiable {
    let id = UUID()
    var title: String
    var message: String
    
}


final class DetailCharacterViewModel: ObservableObject {
    
    private let interactor: Interactor
    
    @Published var character: SimpsonsCharacterDetailBO?
    @Published var episode: SimpsonsEpisodeDetailBO?
    @Published var location: SimpsonsLocationDetailBO?
    @Published var viewState: ViewState = .loading
    @Published var isPresented: Bool = false
    @Published var errorInfo: ErrorWrapper?
    
    init(interactor: Interactor = SimpsonsInteractor(repository: Repository()), character: SimpsonsCharacterDetailBO? = nil, episode: SimpsonsEpisodeDetailBO? = nil, location: SimpsonsLocationDetailBO? = nil) {
        self.interactor = interactor
        self.character = character
        self.episode = episode
        self.location = location
    }
    //MARK: - Load
    func loadCharacter(id: Int?) async {
        do {
            await MainActor.run { viewState = .loading }
            try await Task.sleep(nanoseconds: 1_000_000_000)
            let detailCharacter = try await interactor.getCharacterDetail(id: id!)
            await MainActor.run {
                let mapped = detailCharacter.toBo()
                
                character = mapped
                viewState = .finished
            }
        } catch let err {
            print("ERROR DETAIL \(err.localizedDescription)")
            errorInfo = ErrorWrapper(title: "An error has occurred!", error: ErrorHandler.invalidUrl, guidance: "We couldn’t complete your request.")
        }
    }
    
    func loadEpisode(id: Int?) async {
        do {
            await MainActor.run { viewState = .loading }
            try await Task.sleep(nanoseconds: 1_000_000_000)
            let detailEpisode = try await interactor.getEpisodeDetail(id: id!)
            await MainActor.run {
                let mapped = detailEpisode.toBo()
                episode = mapped
                viewState = .finished
            }
        } catch let err {
            print("ERROR DETAIL \(err.localizedDescription)")
            errorInfo = ErrorWrapper(title: "An error has occurred!", error: ErrorHandler.invalidUrl, guidance: "We couldn’t complete your request.")
        }
    }
    
    func loadLocation(id: Int?) async {
        do {
            await MainActor.run { viewState = .loading }
            try await Task.sleep(nanoseconds: 1_000_000_000)
            let detailLocation = try await interactor.getLocationDetail(id: id!)
            await MainActor.run {
                let mapped = detailLocation.toBo()
                location = mapped
                viewState = .finished
            }
        } catch let err {
            print("ERROR DETAIL \(err.localizedDescription)")
            errorInfo = ErrorWrapper(title: "An error has occurred!", error: ErrorHandler.invalidUrl, guidance: "We couldn’t complete your request.")
        }
    }
}
