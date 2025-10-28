//
//  SimpsonLocationDetailMapper.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 28/10/25.
//

import Foundation

// MARK: - Simpsons Location Detail Mapper
extension SimpsonsLocationDetailDTO {
    func toBo() -> SimpsonsLocationDetailBO {
        SimpsonsLocationDetailBO(id: id,
                                 name: name,
                                 imagePath: URL(string: imagePath ?? ""),
                                 town: town,
                                 use: use)
    }
}
