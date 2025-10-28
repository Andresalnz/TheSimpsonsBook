//
//  DetailCharacterView.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 19/10/23.
//

//import SwiftUI
//
//struct DetailView<T>: View  where T: Detail {
//    
//    let model: T
//    let type: TypeViewList
//    @StateObject var viewModel: DetailViewModel
//    
//    var body: some View {
//        List {
//          DetailContentView
//        }
//        .navigationTitle(model.name ?? Constants.noText)
//        .toolbar(content: {
//            Button("Favorito") {
//                print("FAV")
//            }
//        })
//        .alert(viewModel.errorMsg, isPresented: $viewModel.showAlert) {
//          //
//        } message: {
//            Text(Constants.messageAlertError)
//                .font(.body)
//        }
////        .onAppear {
////            viewModel.loadUI()
////        }
////        .onDisappear {
////            viewModel.remove()
////        }
//        .listStyle(.insetGrouped)
//    }
//    
//    //MARK: - ViewBuilder
//    @ViewBuilder
//    private var DetailContentView: some View {
//        switch type {
//            case .characters:
//               Section  { SectionImageView(model: model) }
//                header: { Text(Constants.titleImage) }
//                    footer: {
//                        Text(model.name ?? Constants.noText)
//                            .frame(maxWidth: .infinity, alignment: .trailing)
//                    }
//                Section(Constants.titleInformation) { SectionInformationView(model: model, type: .characters) }
//               
//        
//            case .episodes:
//                Section(Constants.titleInformation) { SectionInformationView(model: model, type: .episodes) }
//               
//                
//            case .locations:
//                Section(Constants.titleInformation) { SectionInformationView(model: model, type: .locations) }
//               
//        }
//    }
//}
//
//#Preview {
//    DetailView(model: RowDetail(image: URL(string: "https://rickandmortyapi.com/api/character")), type: .episodes, viewModel: DetailViewModel( type: .episodes))
//}
