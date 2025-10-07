//
//  ListWithSeparation.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 30/11/23.
//

import SwiftUI

struct ListWithSeparation<T>: View where T: Detail {
    
    let model: T
    
    var body: some View {
        VStack {
            Text(model.name ?? " no name")
                .frame(maxWidth: .infinity, alignment: .leading)
            HStack {
                if let airDate = model.airDate {
                    Text(airDate)
                }
                
                Spacer()
               
               
            }
        }
        .modifier(StyleList())
    }
}

#Preview {
    ListWithSeparation(model: RowDetail())
}
