//
//  EntityDetailHeaderView.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 1/11/23.
//

import SwiftUI

struct EntityDetailHeaderView: View {
    
    let image: URL?
    let title: String?
    let description: String?
    
    var body: some View {
        VStack(spacing: 12) {
            if let image = image {
                AsyncImage(url: image) { image in
                    image.resizable()
                        .scaledToFill()
                        .background(
                            LinearGradient(
                                colors: [
                                    Color.init(hex: "F8D8AD"),
                                    .white
                                ],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                } placeholder: {
                    ProgressView()
                        .padding()
                }
            } else {
                Image(systemName: "person.fill")
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [
                                Color.init(hex: "F8D8AD"),
                                .white
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 11))
            }
            
            VStack(alignment: .leading, spacing: 12) {
                Text(title ?? "")
                    .font(.title)
                    .bold()
                Text(description ?? "")
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    EntityDetailHeaderView(
        image: Previews.previewDetailCharacter.portraitPath,
        title: Previews.previewDetailCharacter.name,
        description: Previews.previewDetailCharacter.description
    )
}
