//
//  Constants.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 20/10/23.
//

import Foundation
import SwiftUI

//MARK: - Constants
struct Constants {
    //URL'S
    static let uri: String = "https://thesimpsonsapi.com/api"
    static let characters: String = "/characters"
    static let locations: String = "/locations"
    static let episodes: String = "/episodes"
    static let page: String = "?page="
    
    //Texts
    static let titleCharacters: String = "Characters"
    static let titleEpisodes: String = "Episodes"
    static let titleLocations: String = "Locations"
    static let titleResidents: String = "Residents"
    static let titleFavourite: String = "Favourites"
    static let status: String = "Status"
    static let species: String = "Species"
    static let type: String = "Type"
    static let gender: String = "Gender"
    static let origin: String = "Origin"
    static let location: String = "Location"
    static let dimension: String = "Dimension"
    static let airDate: String = "Air Date"
    static let episode: String = "Episode"
    static let titleImage: String = "Image"
    static let titleInformation: String = "Information"
    static let noText: String = "N/A"
    static let searchPrompt: String = "Search..."
    static let messageAlertError: String = "Error en la App, intentelo mas tarde"
    
   static let previewDetailCharacter: SimpsonsCharacterDetailBO = SimpsonsCharacterDetailBO(id: 1, age: 39, birthdate: "1956-05-12", description: "Homer Jay Simpson (born May 12, 1956) is a man from Springfield and the protagonist of the animated television series The Simpsons. He is a crude, ignorant, and slobbish individual, although he is fundamentally a good person and shows great caring and loyalty to his family, friends and on occasion, to those he barely knows or those he considers his enemies.", firstAppearanceEpId: 1, firstAppearanceShId: 1, gender: "Male", name: "Homer Simpsons", occupation: "Safety Inspector", phrases: [
         "Doh!",
         "Why you little...!",
         "Woo-hoo!",
         "Mmm... (food)... *drooling*",
         "Stupid Flanders!",
         "Shut up Flanders!",
         "AAAAGHH!",
         "Lisa, knock off that racket!",
         "Uh oh, the boss.",
         "Lets all go out for frosty chocolate milkshakes!",
         "Whatever, Ill be at Moes.",
         "I am evil Ho-mer! I am evil Ho-mer! I am evil Ho-mer!",
         "Better them than me.",
         "Better them than me... Oh wait, that was me.",
         "Marge, my face hurts again!"
     ], portraitPath: URL(string: ""), status: "Alive", firstAppearanceEp: SimpsonsFirstAppearanceBO(id: 1, airdate: "1989-12-17", description: "\"Simpsons Roasting on an Open Fire\" (also known as \"The Simpsons Christmas Special\") is the first episode of Season 1 of The Simpsons, as well as the series premiere/pilot episode of the series. It is the show's only episode to be aired in the 1980s. (Minus the original shorts.)", episodeNumber: 1, imagePath: URL(string: ""), name: "Simpsons Roasting on an Open Fire", season: 1, synopsis: "When Mr. Burns announces that none of the workers will be getting Christmas bonuses and Marge reveals that she spent the extra Christmas gift money on getting Bart's \"Mother\" tattoo removed, Homer keeps his lack of funds for the holidays a secret and gets a job as a mall Santa."), firstAppearanceSh: nil)

    
    //Constants UI
    static let sizeCornerRadius: CGFloat = 8
    
    //FirebaseFirestore
    static let collectionCharacter: String = "charactersFavs"
    static let collectionEpisodes: String = "episodesFavs"
    static let collectionLocations: String = "locationsFavs"
    
    //Icons
    enum Icons: String {
        case circleFill = "circle.fill"
        case personCircle = "person.circle"
        case personFill = "person.fill"
        case globeAsiaAustraliaFill = "globe.asia.australia.fill"
        case locationFill = "location.fill"
        case mountain2CircleFill = "mountain.2.circle.fill"
        case tvCircle = "tv.circle"
        case ellipsisBubbleFill = "ellipsis.bubble.fill"
    }
}

extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let hasAlpha = hexSanitized.count == 8
        let red = Double((rgb >> (hasAlpha ? 24 : 16)) & 0xFF) / 255.0
        let green = Double((rgb >> (hasAlpha ? 16 : 8)) & 0xFF) / 255.0
        let blue = Double((rgb >> (hasAlpha ? 8 : 0)) & 0xFF) / 255.0
        let alpha = hasAlpha ? Double(rgb & 0xFF) / 255.0 : 1.0

        self.init(red: red, green: green, blue: blue, opacity: alpha)
    }
}

