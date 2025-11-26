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
