//
//  CharacterRowView.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 19/10/23.
//

import SwiftUI

struct RowSimpsonsListHome: View {
    
    let name: String?
    let image: URL?
    let sizeImage: Double
    let text: String?
    
    var body: some View {
        
        HStack(spacing: 20) {
            
                AsyncImage(url: image) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(width: sizeImage)
                       
                      
                        
                }
                placeholder: {
                    ProgressView()
                }
                    
            
            VStack(alignment: .leading, spacing: 4) {
                Text(name ?? Constants.noText)
                    .font(.title3)
                    .lineLimit(2)
                Text(text ?? "")
                    .font(.footnote)
                    .lineLimit(2)
                    
              
            }
        }
        
    }
}

#Preview {

    RowSimpsonsListHome(name: "Homer", image: URL(string: "https://cdn.thesimpsonsapi.com/200/episode/1.webp" ), sizeImage: 150, text: "Saety Guardian")
}
