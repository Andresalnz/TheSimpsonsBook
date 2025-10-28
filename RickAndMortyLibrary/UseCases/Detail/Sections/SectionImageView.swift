//
//  SectionImageView.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 1/11/23.
//

import SwiftUI

struct SectionImageView<T>: View where T: Detail {
    
    let model: T
    
    var body: some View {
        if let image = model.image {
            AsyncImage(url: image) { image in
                image.resizable()
                    .scaledToFill()
                    .listRowBackground(RoundedRectangle(cornerRadius: Constants.sizeCornerRadius)
                        .background(.clear)
                        .foregroundColor(.clear)
                        .padding(.vertical)
                    )
                    .shadow(radius: Constants.sizeCornerRadius)
            }
            placeholder: {
                ProgressView()
            }
            
        } else {
            Image(systemName: "person.fill")
        }
    }
}

#Preview {
    SectionImageView(model: RowDetail(image: URL(string: "")))
}
