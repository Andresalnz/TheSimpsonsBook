//
//  PickerView.swift
//  TheSimpsonsBook
//
//  Created by Andres Aleu on 21/11/25.
//

import SwiftUI
import SwiftData

struct PickerView: View {
    
    @State private var selectedType: FavouriteType = .character
    @Environment(\.modelContext) private var modelContext
   
    @StateObject private var viewModel: FavouritesViewModel
    
    init(context: ModelContext) {
        
        _viewModel = StateObject(
            wrappedValue: FavouritesViewModel(databaseLocal: FavouriteStore(context: context))
        )
    }

    var body: some View {
        Text(selectedType.rawValue)
        VStack {
            Picker("Categoría", selection: $selectedType) {
                ForEach(FavouriteType.allCases) { type in
                    Text(type.title).tag(type)
                }
            }
            .pickerStyle(.segmented)
            .padding([.horizontal, .top])
            
            ListFavouritesView(fileterBy: selectedType, viewModel: viewModel)
        }
    }
}

#Preview {
    let context = sampleContainer.modelCotainer.mainContext
    PickerView(context: context)
        .sampleDataContainer()
}
