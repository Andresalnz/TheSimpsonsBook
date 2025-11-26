//
//  DetailCharcterView.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 28/10/25.
//

import SwiftUI

struct DetailCharcterView: View {
    
    let id: Int?
    let rows = [GridItem(.adaptive(minimum: 150))]
    
    @StateObject var viewModel: DetailViewModel
    
    // MARK: - Favourite
    @State private var isFavourite: Bool = false
    @State private var showConfirmAdd: Bool = false
    @State private var showConfirmRemove: Bool = false
    
    
    var body: some View {
        switch viewModel.viewState {
            case .loading:
                ProgressView()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .task {
                        await viewModel.loadCharacter(id: id)
                    }
            case .finished:
                ScrollView {
                    Text("\(viewModel.character?.characterDetailId ?? 0)")
                    VStack(spacing: 25) {
                        EntityDetailHeaderView(image: viewModel.character?.portraitPath, title: viewModel.character?.name, description: viewModel.character?.description)
                        LazyVGrid(columns: rows, spacing: 20) {
                            EntityDetailCardView(title: "Age", content: viewModel.character?.age)
                            EntityDetailCardView(title: "Birthdate", content: viewModel.character?.birthdate)
                            EntityDetailCardView(title: "Gender", content: viewModel.character?.gender)
                            EntityDetailCardView(title: "Occupation", content: viewModel.character?.occupation)
                        }
                        .padding(.horizontal)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("First Appearance")
                                .font(.title2)
                                .foregroundStyle(Color.init(hex: "000DC2"))
                            Text(viewModel.character?.firstAppearanceEp?.name ?? "")
                                .font(.subheadline)
                            Text("Famous phrases")
                                .font(.title2)
                                .foregroundStyle(Color.init(hex: "000DC2"))
                            ForEach((viewModel.character?.phrases!)!, id: \.self) { phrase in
                                Text(phrase)
                                    .font(.subheadline)
                                
                            }
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                }
                .onAppear {
                    Task {
                      isFavourite = try viewModel.database.isFavorite(type: .character, remoteId: viewModel.character?.characterDetailId)
                    }
                }
                // Toolbar con botón de favorito
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            handleFavouriteButtonTap()
                        } label: {
                            Image(systemName: isFavourite ? "heart.fill" : "heart")
                                .foregroundStyle(isFavourite ? .red : .primary)
                                .accessibilityLabel(isFavourite ? "Eliminar de favoritos" : "Añadir a favoritos")
                        }
                  
                    }
                }
                // Alertas de confirmación
                .alert("Añadir a favoritos", isPresented: $showConfirmAdd) {
                    Button("Cancelar", role: .cancel) {}
                    Button("Añadir", role: .none) {
                        Task {
                           try viewModel.saveToFavorites(type: .character, remoteId: viewModel.character?.characterDetailId, title: viewModel.character?.name, subtitle: viewModel.character?.occupation, imageURL: viewModel.character?.portraitPath, createdAt: .now)
                        }
                        isFavourite = true
                    }
                } message: {
                    Text("¿Quieres guardar este personaje en favoritos?")
                }
                .alert("Eliminar de favoritos", isPresented: $showConfirmRemove) {
                    Button("Cancelar", role: .cancel) {}
                    Button("Eliminar", role: .destructive) {
                        Task {
                          try viewModel.removeoFavorites(type: .character, remoteId: viewModel.character?.characterDetailId)
                            
                        }
                    }
                } message: {
                    Text("¿Quieres eliminar este personaje de tus favoritos?")
                }
            case .error(let error):
                ContentUnavailableView(error.title, systemImage: "exclamationmark.triangle", description: Text(error.guidance))
        }
    }
    
    // MARK: - Helpers Favourites
    private func handleFavouriteButtonTap() {
        if isFavourite {
            showConfirmRemove.toggle()
        } else {
            showConfirmAdd.toggle()
        }
    }
}

#Preview {
    let context = sampleContainer.modelCotainer.mainContext
    DetailCharcterView(id: 1, viewModel: DetailViewModel(database: FavouriteStore(context: context),  character: Previews.previewDetailCharacter))
        .sampleDataContainer()
}
