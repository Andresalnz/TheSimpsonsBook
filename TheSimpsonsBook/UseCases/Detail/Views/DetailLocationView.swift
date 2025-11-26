//
//  DetailLocationView.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 4/11/25.
//

import SwiftUI

struct DetailLocationView: View {
    
    let id: Int?
    let rows = [GridItem(.adaptive(minimum: 150))]
    
    @StateObject var viewModel: DetailViewModel
    @State var isFavourite: Bool = false
    
    var body: some View {
        switch viewModel.viewState {
            case .loading:
                ProgressView()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .task {
                        await viewModel.loadLocation(id: id)
                    }
            case .finished:
                ScrollView {
                    VStack(spacing: 25) {
                        EntityDetailHeaderView(image: viewModel.location?.imagePath, title: viewModel.location?.name, description: viewModel.location?.description)
                        LazyVGrid(columns: rows, spacing: 20) {
                            EntityDetailCardView(title: "Town", content: viewModel.location?.town)
                            EntityDetailCardView(title: "Use", content: viewModel.location?.use)
                        }
                        .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("First Appearance")
                                .font(.title2)
                                .foregroundStyle(Color.init(hex: "000DC2"))
                            Text(viewModel.location?.firstAppearanceEp?.name ?? "N/A")
                                .font(.subheadline)
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                .onAppear {
                    Task {
                        isFavourite = try viewModel.database.isFavorite(type: .location, remoteId: viewModel.location?.locationDetailId)
                    }
                }
                // Toolbar con botón de favorito
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            viewModel.handleFavouriteButtonTap(isFavourite: isFavourite)
                        } label: {
                            Image(systemName: isFavourite ? "heart.fill" : "heart")
                                .foregroundStyle(isFavourite ? .red : .primary)
                                .accessibilityLabel(isFavourite ? "Eliminar de favoritos" : "Añadir a favoritos")
                        }
                  
                    }
                }
                // Alertas de confirmación
                .alert("Add to favourites", isPresented: $viewModel.showConfirmAdd) {
                    Button("Cancel", role: .cancel) {}
                    Button("Add", role: .none) {
                        Task {
                            try viewModel.saveToFavorites(type: .location, remoteId: viewModel.location?.locationDetailId, title: viewModel.location?.name, subtitle: viewModel.location?.town, imageURL: viewModel.location?.imagePath, createdAt: .now)
                        }
                        isFavourite = true
                    }
                } message: {
                    Text("Do you want to save this location to your favourites?")
                }
                .alert("Remove from favourites", isPresented: $viewModel.showConfirmRemove) {
                    Button("Cancel", role: .cancel) {}
                    Button("Remove", role: .destructive) {
                        Task {
                            try viewModel.removeoFavorites(type: .location, remoteId: viewModel.location?.locationDetailId)
                            
                        }
                        isFavourite = false
                    }
                } message: {
                    Text("Are you sure you want to remove this location from your favourites?")
                }
            case .error(let error):
                ContentUnavailableView(error.title, systemImage: "exclamationmark.triangle", description: Text(error.guidance))
        }
    }
}

#Preview {
    let context = sampleContainer.modelCotainer.mainContext
    DetailLocationView(id: 2, viewModel: DetailViewModel(database: FavouriteStore(context: context), character: Previews.previewDetailCharacter, episode: Previews.previewDetailEpisode, location: Previews.previewDetailLocation))
        .sampleDataContainer()
}
