//
//  ErrorView.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 4/11/25.
//

import SwiftUI

struct AppErrorView: View {
    let errorWrapper: ErrorWrapper
    var body: some View {
        VStack(spacing: 12) {
            Text(errorWrapper.title)
                .font(.title)
            Text(errorWrapper.guidance)
                .font(.headline)
                
            if let localizedError = errorWrapper.error as? LocalizedError, let recovery = localizedError.errorDescription, !recovery.isEmpty {
                Text(recovery)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
    }
}

#Preview {
    AppErrorView(errorWrapper: ErrorWrapper(title: "An error has occurred!", error: ErrorHandler.invalidUrl, guidance: "We couldn’t complete your request."))
}
