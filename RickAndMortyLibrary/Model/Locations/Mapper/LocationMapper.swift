//
//  LocationMapper.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 20/11/23.
//

import Foundation

extension SimpsonsLocationDTO {
    func toBo() -> SimpsonsLocationBO {
       SimpsonsLocationBO(name: name,
                          imagePath: imagePath,
                          dimension: dimension,
                          town: town,
                          use: use)
        
    }
}

