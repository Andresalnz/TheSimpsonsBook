//
//  LoadingView.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 21/10/25.
//

import SwiftUI

struct LoadingView: View {
    let title: String
    var body: some View {
        ProgressView(title)
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets())
            .frame(maxWidth: .infinity)
    }
}

#Preview {
    LoadingView(title: "Cargando mas personajes")
}
