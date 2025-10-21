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
            .modifier(ListRowLoadingStyle())
    }
}

#Preview {
    LoadingView(title: "Cargando mas personajes")
}
