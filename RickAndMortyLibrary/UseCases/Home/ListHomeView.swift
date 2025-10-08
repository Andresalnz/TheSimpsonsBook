//
//  ListCharactersView.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 19/10/23.
//

import SwiftUI

enum TypeViewList: String {
    case characters = "/apicharacters"
    case episodes = "/api/episodes"
    case locations = "/apilocations"
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
        //.listStyle(.plain)
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
                viewModel.loadUI(type)
            //}
        }
    }
    
    //MARK: - ViewBuilder
    @ViewBuilder
    private var HomeContentView: some View {
        switch type {
            case .characters:
                ForEach(viewModel.searchCharacters, id: \.id) { character in
                    CharacterRowView(name: character.name, image: character.imageURL, sizeImage: 70, text: character.occupation)
                }
            case .episodes:
                ForEach(viewModel.searchEpisodes, id: \.id) { episode in
                    CharacterRowView(name: episode.name, image: episode.imageURL, sizeImage: 150, text: episode.synopsis)
                }
                
            case .locations:
                ForEach(viewModel.searchLocations, id: \.id) { location in
                    CharacterRowView(name: location.name, image: location.imageURL, sizeImage: 150, text: location.town)
                }
        }
    }
}

#Preview {
    ListHomeView(type: .episodes, navigationTitle: "Characters").environmentObject(ListHomeViewModel(type: .episodes))
}
