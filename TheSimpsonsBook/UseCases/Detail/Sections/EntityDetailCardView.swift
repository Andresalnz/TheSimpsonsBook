//
//  EntityDetailCardView.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 1/11/23.
//

import SwiftUI

struct EntityDetailCardView: View {
    
    let title: String?
    let content: String?
    
    var body: some View {
        VStack(spacing: 7) {
            Text(title ?? "N/A")
                .font(.subheadline)
                .foregroundStyle(Color.init(hex: "000DC2"))
            Text(content ?? "N/A")
                .lineLimit(2)
                .font(.title2)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical)
        .background(
            Color.init(hex: "f8d8ad")
        )
        .clipShape(RoundedRectangle(cornerRadius: 10.0))
        .shadow(color: .black.opacity(0.2), radius: 5, x: 2, y: 2)
    }
}

#Preview {
    EntityDetailCardView(title: "Ocupation", content: Previews.previewDetailCharacter.occupation)
}
