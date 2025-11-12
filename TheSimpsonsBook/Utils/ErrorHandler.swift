//
//  ErrorHandler.swift
//  RickAndMortyLibrary
//
//  Created by Andres Aleu on 20/10/23.
//

import Foundation

//MARK: - ErrorHandler
enum ErrorHandler: LocalizedError, Error {
    case invalidUrl
    case requestInvalid
    case requestNotWork
    
    //Firebase
    case FirestoreNotSaveDocument
    case FirestoreNotGetDocuments
    
   
    
    public var errorDescription: String? {
        switch self {
            case .invalidUrl:
                return NSLocalizedString("Please check the URL format and try again.", comment: "La url introducida es invalida")
            case .requestNotWork:
                return NSLocalizedString("Error en el servidor", comment: "No se ha podido realizar las peticiones")
            case .requestInvalid:
                return NSLocalizedString("Petición invalidada", comment: "Petición invalidada")
            case .FirestoreNotSaveDocument:
                return NSLocalizedString("No se pudo guardar el documento", comment: "No se pudo guardar el documento")
            case .FirestoreNotGetDocuments:
                return NSLocalizedString("No se pudo obtener los documentos", comment: "No se pudo obtener los documentos")
        }
    }
}
