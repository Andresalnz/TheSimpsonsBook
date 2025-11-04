//
//  DetailEpisodeView.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 4/11/25.
//

import SwiftUI

struct DetailEpisodeView: View {
    let id: Int?
    @StateObject var viewModel: DetailCharacterViewModel = DetailCharacterViewModel()
    
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
                   VStack(alignment: .leading, spacing: 12) {
                       Text(viewModel.episode?.name ?? "Sin nombre")
                           .font(.title2)
                           .bold()
                       Text(viewModel.episode?.description ?? "Sin descripción")
                           .font(.body)
                   }
                   .frame(maxWidth: .infinity, alignment: .leading)
                   .padding()
               }
            case .error(let error):
                AppErrorView(errorWrapper: error)
        }
    }
}

#Preview {
    DetailEpisodeView(id: 1, viewModel: DetailCharacterViewModel(character: Previews.previewDetailCharacter, episode: Previews.previewDetailEpisode, location: Previews.previewDetailLocation))
}
