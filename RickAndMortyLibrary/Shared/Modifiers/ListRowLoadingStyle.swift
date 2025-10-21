//
//  List.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 21/10/25.
//

import SwiftUI

struct ListRowLoadingStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets())
            .frame(maxWidth: .infinity)
    }
}
