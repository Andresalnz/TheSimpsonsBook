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

struct ListHomeView: View {
    
    //MARK: - ViewModel
    @EnvironmentObject var viewModel: ListHomeViewModel
    
    var type: TypeViewList
    let navigationTitle: String?
    
    var body: some View {
        NavigationStack {
            List {
                HomeContentView
            }
            .navigationDestination(for: SimpsonsCharacterBO.self, destination: { character in
                DetailCharcterView(id: character.characterId)
            })
            .navigationTitle(navigationTitle ?? Constants.noText)
        }
        .navigationViewStyle(.stack)
        .searchable(text: $viewModel.searchText, prompt: Constants.searchPrompt)
        .alert(viewModel.errorMsg, isPresented: $viewModel.showAlert) {
            //
        } message: {
            Text(Constants.messageAlertError)
                .font(.body)
        }
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
                    NavigationLink(value: character, label: {
                        CharacterRowView(name: character.name, image: character.imageURL, sizeImage: 70, text: character.occupation)
                    })
                        .onAppear {
                            if viewModel.checkTheLastIdCharacters(.characters, of: character.id) {
                                Task {
                                    await viewModel.load(type, mode: .nextPage)
                                }
                            }
                        }
                    if viewModel.isLoading && viewModel.checkTheLastIdCharacters(.characters, of: character.id) {
                        LoadingView(title: "Loading more Characters")
                        
                    }
                }
            case .episodes:
                if viewModel.episodes.isEmpty {
                    LoadingView(title: "Loading Episodes")
                }
                ForEach(viewModel.episodes, id: \.id) { episode in
                    CharacterRowView(name: episode.name, image: episode.imageURL, sizeImage: 150, text: episode.synopsis)
                        .onAppear {
                            if viewModel.checkTheLastIdCharacters(.episodes, of: episode.id) {
                                Task {
                                    await viewModel.load(type, mode: .nextPage)
                                }
                            }
                        }
                    if viewModel.isLoading && viewModel.checkTheLastIdCharacters(.episodes, of: episode.id) {
                        LoadingView(title: "Loading more Episodes")
                        
                    }
                }
            case .locations:
                if viewModel.locations.isEmpty {
                    LoadingView(title: "Loading Locations")
                }
                ForEach(viewModel.locations, id: \.id) { location in
                    CharacterRowView(name: location.name, image: location.imageURL, sizeImage: 150, text: location.town)
                        .onAppear {
                            if viewModel.checkTheLastIdCharacters(.locations, of: location.id) {
                                Task {
                                    await viewModel.load(type, mode: .nextPage)
                                }
                            }
                        }
                    if viewModel.isLoading && viewModel.checkTheLastIdCharacters(.locations, of: location.id) {
                        LoadingView(title: "Loading more Locations")
                        
                    }
                }
        }
    }
}

#Preview {
    ListHomeView(type: .episodes, navigationTitle: "Characters").environmentObject(ListHomeViewModel(type: .episodes))
}
