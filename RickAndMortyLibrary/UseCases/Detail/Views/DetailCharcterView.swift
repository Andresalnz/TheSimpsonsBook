//
//  DetailCharcterView.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 28/10/25.
//

import SwiftUI

struct DetailCharcterView: View {
    
    let id: Int?
    @StateObject var viewModel: DetailViewModel = DetailViewModel()
    
    @State private var showAlert = false
    @State private var errorMessage = "Ha ocurrido un error al cargar el detalle."
    
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
                    VStack(alignment: .leading, spacing: 12) {
                        Text(viewModel.character?.name ?? "Sin nombre")
                            .font(.title2)
                            .bold()
                        Text(viewModel.character?.description ?? "Sin descripción")
                            .font(.body)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                }
            case .error(let error):
                ContentUnavailableView(error.title, systemImage: "exclamationmark.triangle", description: Text(error.guidance))
        }
        
    
    }
}

#Preview {
    DetailCharcterView(id: 1, viewModel: DetailViewModel(character: Previews.previewDetailCharacter, episode: Previews.previewDetailEpisode, location: Previews.previewDetailLocation))
}
