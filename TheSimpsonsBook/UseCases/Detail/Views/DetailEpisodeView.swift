//
//  DetailEpisodeView.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 4/11/25.
//

import SwiftUI

struct DetailEpisodeView: View {
    
    let id: Int?
    let rows = [GridItem(.adaptive(minimum: 150))]
    
    @StateObject var viewModel: DetailViewModel
    @State private var isFavourite: Bool = false

    var body: some View {
        switch viewModel.viewState {
            case .loading:
                ProgressView()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .task {
                        await viewModel.loadEpisode(id: id)
                    }
            case .finished:
                ScrollView {
                    VStack(spacing: 25) {
                        EntityDetailHeaderView(image: viewModel.episode?.imagePath, title: viewModel.episode?.name, description: viewModel.episode?.description)
                        LazyVGrid(columns: rows, spacing: 20) {
                            EntityDetailCardView(title: "Episode", content: viewModel.episode?.episodeNumber)
                            EntityDetailCardView(title: "Season", content: viewModel.episode?.season)
                        }
                        .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Synopsis")
                                .font(.title2)
                                .foregroundStyle(Color.init(hex: "000DC2"))
                            Text(viewModel.episode?.synopsis ?? "No synopsis available")
                            
                        }
                        .padding(.horizontal)
                    }
                }
                .onAppear {
                    Task {
                        isFavourite = try viewModel.database.isFavorite(type: .episode, remoteId: viewModel.episode?.episodeDetailId)
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
                            try viewModel.saveToFavorites(type: .episode, remoteId: viewModel.episode?.episodeDetailId, title: viewModel.episode?.name, subtitle: viewModel.episode?.description, imageURL: viewModel.episode?.imagePath, createdAt: .now)
                        }
                        isFavourite = true
                    }
                } message: {
                    Text("Do you want to save this episode to your favourites?")
                }
                .alert("Remove from favourites", isPresented: $viewModel.showConfirmRemove) {
                    Button("Cancel", role: .cancel) {}
                    Button("Remove", role: .destructive) {
                        Task {
                          try viewModel.removeFavorites(type: .episode, remoteId: viewModel.episode?.episodeDetailId)
                            
                        }
                        isFavourite = false
                    }
                } message: {
                    Text("Are you sure you want to remove this episode from your favourites?")
                }
            case .error(let error):
                ContentUnavailableView(error.title, systemImage: "exclamationmark.triangle", description: Text(error.guidance))
        }
    }
}

#Preview {
    let context = sampleContainer.modelCotainer.mainContext
    DetailEpisodeView(id: 1, viewModel: DetailViewModel(database: FavouriteStore(context: context), character: Previews.previewDetailCharacter, episode: Previews.previewDetailEpisode, location: Previews.previewDetailLocation))
        .sampleDataContainer()
}
