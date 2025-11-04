//
//  ErrorWrapper.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 4/11/25.
//

import Foundation

struct ErrorWrapper: Identifiable {
    let id: UUID = UUID()
    let title: String
    let error: Error
    let guidance: String
}
