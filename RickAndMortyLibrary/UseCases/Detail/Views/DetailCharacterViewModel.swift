//
//  DetailCharacterViewModel.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 28/10/25.
//

import Foundation

final class DetailCharacterViewModel: ObservableObject {
    
    private let interactor: Interactor
    
    @Published var character: SimpsonsCharacterDetailBO
    
    init(interactor: Interactor = SimpsonsInteractor(repository: Repository()), character: SimpsonsCharacterDetailBO) {
        self.interactor = interactor
        self.character = character
    }
    
    //MARK: - Load
    func load(id: Int) async throws {
        do {
            let detailCharacter = try await interactor.getCharacterDetail(id: id)
            await MainActor.run {
                let mapped = detailCharacter.toBo()
                character = mapped
            }
        } catch let err {
            print(err)
            throw ErrorHandler.requestInvalid
        }
        
    }
}

//
//extension DetailCharacterViewModel {
//   static let previewDetailCharacter: SimpsonsCharacterDetailBO = SimpsonsCharacterDetailBO(id: 1, age: 39, birthdate: "1956-05-12", description: "Homer Jay Simpson (born May 12, 1956) is a man from Springfield and the protagonist of the animated television series The Simpsons. He is a crude, ignorant, and slobbish individual, although he is fundamentally a good person and shows great caring and loyalty to his family, friends and on occasion, to those he barely knows or those he considers his enemies.", firstAppearanceEpId: 1, firstAppearanceShId: 1, gender: "Male", name: "Homer Simpsons", occupation: "Safety Inspector", phrases: [
//        "Doh!",
//        "Why you little...!",
//        "Woo-hoo!",
//        "Mmm... (food)... *drooling*",
//        "Stupid Flanders!",
//        "Shut up Flanders!",
//        "AAAAGHH!",
//        "Lisa, knock off that racket!",
//        "Uh oh, the boss.",
//        "Lets all go out for frosty chocolate milkshakes!",
//        "Whatever, Ill be at Moes.",
//        "I am evil Ho-mer! I am evil Ho-mer! I am evil Ho-mer!",
//        "Better them than me.",
//        "Better them than me... Oh wait, that was me.",
//        "Marge, my face hurts again!"
//    ], portraitPath: URL(string: ""), status: "Alive", firstAppearanceEp: SimpsonsFirstAppearanceBO(id: 1, airdate: "1989-12-17", description: "\"Simpsons Roasting on an Open Fire\" (also known as \"The Simpsons Christmas Special\") is the first episode of Season 1 of The Simpsons, as well as the series premiere/pilot episode of the series. It is the show's only episode to be aired in the 1980s. (Minus the original shorts.)", episodeNumber: 1, imagePath: URL(string: ""), name: "Simpsons Roasting on an Open Fire", season: 1, synopsis: "When Mr. Burns announces that none of the workers will be getting Christmas bonuses and Marge reveals that she spent the extra Christmas gift money on getting Bart's \"Mother\" tattoo removed, Homer keeps his lack of funds for the holidays a secret and gets a job as a mall Santa."), firstAppearanceSh: nil)
//}
