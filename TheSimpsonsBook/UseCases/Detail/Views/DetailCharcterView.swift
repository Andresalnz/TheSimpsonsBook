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
    
    @StateObject var viewModel: DetailViewModel = DetailViewModel()
    
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
            case .error(let error):
                ContentUnavailableView(error.title, systemImage: "exclamationmark.triangle", description: Text(error.guidance))
        }
    }
}

#Preview {
    DetailCharcterView(id: 1, viewModel: DetailViewModel(character: Previews.previewDetailCharacter))
}
