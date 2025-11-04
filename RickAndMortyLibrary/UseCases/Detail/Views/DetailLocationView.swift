//
//  DetailLocationView.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 4/11/25.
//

import SwiftUI

struct DetailLocationView: View {
    
    let id: Int?
    @StateObject var viewModel: DetailViewModel = DetailViewModel()
    
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
                    VStack(alignment: .leading, spacing: 12) {
                        Text(viewModel.location?.name ?? "Sin nombre")
                            .font(.title2)
                            .bold()
                        Text(viewModel.location?.description ?? "Sin descripción")
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
    DetailLocationView(id: 1, viewModel: DetailViewModel(character: Previews.previewDetailCharacter, episode: Previews.previewDetailEpisode, location: Previews.previewDetailLocation))
}
