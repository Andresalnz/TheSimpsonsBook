//
//  NavigationManager.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 3/11/25.
//

import Foundation
import SwiftUI

final class NavigationManager: ObservableObject {
    
    @Published var path = NavigationPath()
    
    func navigate(to route: AppRoute) {
        path.append(route)
    }
}
