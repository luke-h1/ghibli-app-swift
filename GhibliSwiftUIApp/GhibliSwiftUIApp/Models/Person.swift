import Foundation
//
//  Person.swift
//  GhibliSwiftUIApp
//
//  Created by luke howsam on 28/08/2026.
//

struct Person: Identifiable, Decodable, Equatable {
    let id: String
    let name: String
    let gender: String
    let age: String
    let eyeColor: String
    let hairColor: String
    let films: [String]
    let species: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case gender
        case age
        case eyeColor = "eye_color"
        case hairColor = "hair_color"
        case films
        case species
        case url
    }
}
