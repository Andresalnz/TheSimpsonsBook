//
//  TheSimpsonsBookApp.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 12/11/25.
//

import SwiftUI
import SwiftData

@main
struct TheSimpsonsBookApp: App {
    let dataContainer = DataContainer()
    
    var body: some Scene {
        WindowGroup {
           TabBarView()
                
        }
        .modelContainer(dataContainer.modelCotainer)
        
    }
}
