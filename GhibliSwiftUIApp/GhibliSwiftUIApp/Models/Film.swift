import Foundation
//
//  Film.swift
//  GhibliSwiftUIApp
//
//  Created by luke howsam on 28/08/2026.
//

struct Film: Codable, Identifiable, Equatable, Hashable {
    let id: String
    let title: String
    let image: String
    let description: String
    let releaseDate: String
    let bannerImage: String
    let producer: String
    let director: String
    let duration: String
    let score: String
    
    let people: [String]
    
    enum CodingKeys: String, CodingKey {
        case id, title, image, description, director, producer, people
        
        case bannerImage = "movie_banner"
        
        case duration = "running_time"
        case score = "rt_score"
        case releaseDate = "release_date"
    }
    
}

