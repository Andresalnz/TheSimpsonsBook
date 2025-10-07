//
//  CharacterRowView.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 19/10/23.
//

import SwiftUI

struct CharacterRowView: View {
    
    let name: String?
    let image: URL?
    
    var body: some View {
        
        HStack {
            if let image = image {
                AsyncImage(url: URL(string: "https://cdn.thesimpsonsapi.com/500\(image)" ) ) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 20.0), style: FillStyle())
                }
                placeholder: {
                    ProgressView()
                }
                    
            } else {
                Image(systemName: "person.fill")
            }
            VStack(alignment: .leading) {
                Text(name ?? Constants.noText)
                    .font(.title3)
              
            }
        }
    }
}

#Preview {
    CharacterRowView(name: "Homer", image: URL(string: "https://cdn.thesimpsonsapi.com/500/character/1.webp" ))
}
