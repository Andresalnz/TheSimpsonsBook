//
//  LocationMapper.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 20/11/23.
//

import Foundation

extension SimpsonsLocationDTO {
    func toBo() -> SimpsonsLocationBO {
     SimpsonsLocationBO(locationId: locationId,
                        name: name,
                        imagePath: URL(string: "https://cdn.thesimpsonsapi.com/500\(imagePath ?? "")"),
                        dimension: dimension,
                        town: town,
                        use: use)
    }
}

