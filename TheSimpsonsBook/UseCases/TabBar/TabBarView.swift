//
//  TabBarView.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 19/12/23.
//

import SwiftUI

struct TabBarView: View {
    
    @State private var searchText: String = ""
    @Environment(\.modelContext) private var modelContext
    
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
            
            Tab(Constants.titleFavourite, systemImage: "heart.fill") {
               PickerView(context: modelContext)
            }
           
            Tab(role: .search) {
                NavigationStack {
                    Text("Search")
                }
            }
            
            
        }
        .searchable(text: $searchText, prompt: "Enter any search...")
    }
}

#Preview {
    return TabBarView()
        .sampleDataContainer()
}
