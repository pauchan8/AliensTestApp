//
//  Errors.swift
//  AliensTestApp
//
//  Created by Pavlo Deineha on 05.07.2021.
//

enum APIServiceError: Error {
    case responseUnsuccessful
}

enum ParseError: Error {
    case couldNotParseString
}
