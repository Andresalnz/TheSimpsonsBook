//
//  TabBarView.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 19/12/23.
//

import SwiftUI

struct TabBarView: View {
    
    @State private var searchText: String = ""
    
    var body: some View {
        TabView {
            Tab(Constants.titleCharacters, systemImage: "person.fill") {
                ListHomeView(type: .characters, navigationTitle: Constants.titleCharacters).environmentObject(ListHomeViewModel(type: .characters))
            }
            
            Tab(Constants.titleEpisodes, systemImage: "book.fill") {
                ListHomeView(type: .episodes, navigationTitle: Constants.titleEpisodes).environmentObject(ListHomeViewModel(type: .episodes))
            }
            
            Tab(Constants.titleLocations, systemImage: "globe.fill") {
                ListHomeView(type: .locations, navigationTitle: Constants.titleLocations).environmentObject(ListHomeViewModel(type: .locations))
            }
            
           
            Tab(role: .search) {
                NavigationStack {
                    Text("Search")
                }
            }
            
            
            
            
//            FavouritesView(viewModel: FavouritesViewModel(typeList: .locations))
//                .tabItem {
//                    Image(systemName: "heart")
//                    Text(Constants.titleFavourite)
//                }
        }
        .searchable(text: $searchText, prompt: "Enter any search...")
    }
}

#Preview {
    TabBarView()
}
