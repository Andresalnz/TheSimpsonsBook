//
//  DetailCharcterView.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 28/10/25.
//

import SwiftUI

struct DetailCharcterView: View {
    
    let id: Int?
    @StateObject var viewModel: DetailCharacterViewModel = DetailCharacterViewModel(character: Constants.previewDetailCharacter)
    
    @State private var showAlert = false
    @State private var errorMessage = "Ha ocurrido un error al cargar el detalle."
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Text(viewModel.character.name ?? "Sin nombre")
                    .font(.title2)
                    .bold()
                Text(viewModel.character.description ?? "Sin descripción")
                    .font(.body)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .task {
            guard let id else {
                errorMessage = "Identificador no válido."
                showAlert = true
                return
            }
            do {
                try await viewModel.load(id: id)
            } catch {
                errorMessage = "No se pudo cargar el detalle del personaje. Inténtalo de nuevo."
                showAlert = true
            }
        }
        .alert("Error", isPresented: $showAlert) {
            Button("Aceptar", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
    }
}

#Preview {
    DetailCharcterView(id: 1, viewModel: DetailCharacterViewModel(character: Constants.previewDetailCharacter ))
}
