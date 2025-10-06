//
//  SectionInformationView.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 1/11/23.
//

import SwiftUI

struct SectionInformationView<T>: View where T: Detail {
    
    let model: T
    let type: TypeViewList
    
    var body: some View {
        switch type {
            case .characters:
                InfoDetailCharacterRowView(icon: Constants.Icons.circleFill.rawValue, label: Constants.status, value: Text(model.status?.rawValue ?? "").foregroundColor(model.status == .alive ? .green : .black))
                InfoDetailCharacterRowView(icon: Constants.Icons.personCircle.rawValue, label: Constants.species, value: Text(""))
                if model.type != "" {
                    InfoDetailCharacterRowView(icon: Constants.Icons.personCircle.rawValue, label: Constants.type, value: Text(model.type ?? Constants.noText))
                }
                InfoDetailCharacterRowView(icon: Constants.Icons.personFill.rawValue, label: Constants.gender, value: Text(model.gender?.rawValue ?? Constants.noText))
                InfoDetailCharacterRowView(icon: Constants.Icons.globeAsiaAustraliaFill.rawValue, label: Constants.origin, value: Text(model.origin?.name ?? Constants.noText))
                InfoDetailCharacterRowView(icon: Constants.Icons.locationFill.rawValue, label: Constants.location, value: Text(model.location?.name ?? Constants.noText))
            case .locations:
                InfoDetailCharacterRowView(icon: Constants.Icons.personFill.rawValue, label: Constants.type, value: Text(model.type ?? Constants.noText))
                InfoDetailCharacterRowView(icon: Constants.Icons.mountain2CircleFill.rawValue, label: Constants.dimension, value: Text(model.dimension ?? Constants.noText))
            case .episodes:
                InfoDetailCharacterRowView(icon: Constants.Icons.tvCircle.rawValue, label: Constants.airDate, value: Text(model.airDate ?? Constants.noText))
                InfoDetailCharacterRowView(icon: Constants.Icons.ellipsisBubbleFill.rawValue, label: Constants.episode, value: Text(model.episode ?? Constants.noText))
        }
        
        
    }
}

#Preview {
    SectionInformationView(model: RowDetail(), type: .characters)
}
