//
//  DataContainer.swift
//  TheSimpsonsBook
//
//  Created by Andres Aleu on 18/11/25.
//

import Foundation
import SwiftData
import SwiftUI

@MainActor
@Observable
class DataContainer {
    
    let modelCotainer: ModelContainer
    
    var context: ModelContext {
        modelCotainer.mainContext
    }
    
    init(includeItems: Bool = false) {
        let schema = Schema([
            FavouriteModel.self,
        ])
        
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: includeItems)
       
        do {
            modelCotainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
            if includeItems {
                loadSampleData()
            }
            try context.save()
            
        } catch  {
            fatalError()
        }
            
    }
    
    private func loadSampleData() {
        for item in FavouriteModel.sampleData {
            context.insert(item)
        }
    }
}

@MainActor private let sampleContainer = DataContainer(includeItems: true)

extension View {
    func sampleDataContainer() -> some View {
        self
            .environment(sampleContainer)
            .modelContainer(sampleContainer.modelCotainer)
    }
}
