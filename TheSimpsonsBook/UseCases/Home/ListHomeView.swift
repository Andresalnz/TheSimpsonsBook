//
//  ListCharactersView.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 19/10/23.
//

import SwiftUI

enum TypeViewList: String {
    case characters = "/api/characters"
    case episodes = "/api/episodes"
    case locations = "/api/locations"
}

enum AppRoute: Hashable {
    case characters(SimpsonsCharacterBO)
    case episodes(SimpsonsEpisodeBO)
    case locations(SimpsonsLocationBO)
}

struct ListHomeView: View {
    
    //MARK: - ViewModel
    @EnvironmentObject var viewModel: ListHomeViewModel
    @State var path = NavigationPath()
    @Environment(\.modelContext) private var context
    var type: TypeViewList
    let navigationTitle: String?
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                HomeContentView
            }
            .navigationDestination(for: AppRoute.self, destination: { route in
                switch route {
                    case .characters(let character):
                        DetailCharcterView(id: character.characterId, viewModel: DetailViewModel(database: FavouriteStore(context: context)))
                    case .episodes(let episode):
                        DetailEpisodeView(id: episode.episodeId, viewModel: DetailViewModel(database: FavouriteStore(context: context)))
                    case .locations(let location):
                        DetailLocationView(id: location.locationId, viewModel: DetailViewModel(database: FavouriteStore(context: context)))
                }
            })
            .navigationTitle(navigationTitle ?? Constants.noText)
        }
        .navigationViewStyle(.stack)
       
        
        .task {
            await viewModel.load(type, mode: .initial)
        }
    }
    
    //MARK: - ViewBuilder
    @ViewBuilder
    private var HomeContentView: some View {
        switch type {
            case .characters:
                if viewModel.characters.isEmpty {
                    LoadingView(title: "Loading Characters")
                }
                ForEach(viewModel.characters, id: \.id) { character in
                    
                    NavigationLink(value: AppRoute.characters(character), label: {
                        RowSimpsonsListHome(name: character.name, image: character.portraitPath, sizeImage: 70, text: character.occupation)
                    })
                        .onAppear {
                            if viewModel.checkTheLastIdCharacters(.characters, of: character.id) {
                                Task {
                                    await viewModel.load(type, mode: .nextPage)
                                }
                            }
                        }
                    if  viewModel.checkTheLastIdCharacters(.characters, of: character.id) {
                        LoadingView(title: "Loading more Characters")
                        
                    }
                }
            case .episodes:
                if viewModel.episodes.isEmpty {
                    LoadingView(title: "Loading Episodes")
                }
                ForEach(viewModel.episodes, id: \.id) { episode in
                    NavigationLink(value: AppRoute.episodes(episode), label: {
                        RowSimpsonsListHome(name: episode.name, image: episode.imagePath, sizeImage: 150, text: episode.synopsis)
                    })
                        .onAppear {
                            if viewModel.checkTheLastIdCharacters(.episodes, of: episode.id) {
                                Task {
                                    await viewModel.load(type, mode: .nextPage)
                                }
                            }
                        }
                    if  viewModel.checkTheLastIdCharacters(.episodes, of: episode.id) {
                        LoadingView(title: "Loading more Episodes")
                        
                    }
                }
            case .locations:
                if viewModel.locations.isEmpty {
                    LoadingView(title: "Loading Locations")
                }
                ForEach(viewModel.locations, id: \.id) { location in
                    NavigationLink(value: AppRoute.locations(location), label: {
                        RowSimpsonsListHome(name: location.name, image: location.imagePath, sizeImage: 150, text: location.town)
                    })
                        .onAppear {
                            if viewModel.checkTheLastIdCharacters(.locations, of: location.id) {
                                Task {
                                    await viewModel.load(type, mode: .nextPage)
                                }
                            }
                        }
                    if  viewModel.checkTheLastIdCharacters(.locations, of: location.id) {
                        LoadingView(title: "Loading more Locations")
                        
                    }
                }
        }
    }
}

#Preview {
    ListHomeView(type: .episodes, navigationTitle: "Characters").environmentObject(ListHomeViewModel(type: .episodes))
}
