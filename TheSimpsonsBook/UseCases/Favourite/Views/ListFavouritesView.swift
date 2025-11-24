//
//  ListFavouritesView.swift
//  TheSimpsonsBook
//
//  Created by Andres Aleu on 21/11/25.
//

import SwiftUI
import SwiftData


struct FavoritesScreenFactory: View {
    @Environment(\.modelContext) private var context
    
    var body: some View {
        // Aquí el context YA existe.
        // Creamos las dependencias y se las pasamos a la vista real.
        let repository = FavouriteStore(context: context)
        let viewModel = FavouritesViewModel(databaseLocal: repository)
        
        ListFavouritesView(fileterBy: .character, viewModel: viewModel)
    }
}

struct ListFavouritesView: View {
    
    @Query var favouritesCharacters: [FavouriteModel]

    @ObservedObject private var viewModel: FavouritesViewModel
    
    init(fileterBy option: FavouriteType, viewModel: FavouritesViewModel) {
        let targetRaw = option.rawValue
        _viewModel = ObservedObject(wrappedValue: viewModel)
        
        let predicate = #Predicate<FavouriteModel> { item in
           
            item.typeRaw == targetRaw
        }
        _favouritesCharacters = Query(filter: predicate)
    }
  
    
    var body: some View {
        
        if favouritesCharacters.isEmpty {
            ContentUnavailableView("No favourites yet",
                                   systemImage: "heart",
                                   description: Text("Items you mark as favourite will appear here."))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            List {
                ForEach(favouritesCharacters) { fav in
                    RowSimpsonsListHome(
                        name: fav.title,
                        image: fav.imageURL,
                        sizeImage: 70,
                        text: fav.subtitle
                    )
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            Task { await viewModel.onDelete(in: fav) }
                        } label: {
                            Label("Delete", systemImage: "trash.fill")
                        }
                    }
                }
            }
           
        }
    }
}

#Preview {
    let context = sampleContainer.modelCotainer.mainContext
    ListFavouritesView(fileterBy: .character, viewModel: FavouritesViewModel(databaseLocal: FavouriteStore(context: context)))
        .sampleDataContainer()
}
