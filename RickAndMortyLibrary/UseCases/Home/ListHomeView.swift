//
//  ListCharactersView.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 19/10/23.
//

import SwiftUI

enum TypeViewList {
    case characters
    case locations
    case episodes
}

struct ListHomeView: View {
    
    //MARK: - ViewModel
    @EnvironmentObject var viewModel: ListHomeViewModel
    
    var type: TypeViewList
    let navigationTitle: String?
    
    var body: some View {
        NavigationView {
                List {
                    HomeContentView
                }
            .navigationTitle(navigationTitle ?? Constants.noText)
        }
        .listStyle(.plain)
        .navigationViewStyle(.stack)
        .searchable(text: $viewModel.searchText, prompt: Constants.searchPrompt)
        .alert(viewModel.errorMsg, isPresented: $viewModel.showAlert) {
            //
        } message: {
            Text(Constants.messageAlertError)
                .font(.body)
        }
        .onAppear {
           // if viewModel.stateLoadListOnce() {
                viewModel.loadUI()
            //}
        }
    }
    
    //MARK: - ViewBuilder
    @ViewBuilder
    private var HomeContentView: some View {
        switch type {
            case .characters:
                ForEach(viewModel.characters, id: \.id) { character in
                    CharacterRowView(name: character.name, image: character.portraitPath)
                }
            case .episodes:
                ForEach(viewModel.episodes, id: \.id) { episode in
                    CharacterRowView(name: episode.name, image: episode.imagePath)
                }
                
            case .locations:
                ForEach(viewModel.locations, id: \.id) { location in
                    CharacterRowView(name: location.name, image: location.imagePath)
                }
//                ForEach(viewModel.searchLocations, id: \.id) { location in
//                    NavigationLink(destination: DetailView(model: location.rowDetail, type: .locations, viewModel: DetailViewModel(allEpisodeCharacter: location.residents!, type: .locations))) {
//                        TitleRowView(type: location.rowListMain)
//                            .onAppear {
//                                if !viewModel.isLoading && viewModel.checkTheLastIdLocations(of: location) {
//                                    viewModel.loadMoreIfNeeded()
//                                }
//                            }
//                    }
//                }
//                .modifier(StyleList())
        }
    }
}

#Preview {
    ListHomeView(type: .locations, navigationTitle: "Characters").environmentObject(ListHomeViewModel(type: .locations))
}
