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

extension Film {
    static let samples: [Film] = [
        Film(
            id: "2baf70d1-42bb-4437-b551-e5fed5a87abe",
            title: "Castle in the Sky",
            image: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/npOnzAbLh6VOIu3naU5QaEcTepo.jpg",
            description: "Sheeta and Pazu race sky pirates and soldiers to the fabled floating city of Laputa.",
            releaseDate: "1986",
            bannerImage: "https://image.tmdb.org/t/p/w533_and_h300_bestv2/3cyjYtLWCBE1uvWINHFsFnE8LUK.jpg",
            producer: "Isao Takahata",
            director: "Hayao Miyazaki",
            duration: "124",
            score: "95",
            people: []
        ),
        Film(
            id: "12cfb892-aac0-4c5b-94af-521852e46d6a",
            title: "Grave of the Fireflies",
            image: "https://image.tmdb.org/t/p/w600_and_h900_bestv2/qG3RYlIVpTYclR9TYIsy8p7m7Ab.jpg",
            description: "Two orphaned siblings struggle to survive in wartime Japan.",
            releaseDate: "1988",
            bannerImage: "https://image.tmdb.org/t/p/w533_and_h300_bestv2/rc5ZLjB8Ff0mSc8jl6LbjmVSGQr.jpg",
            producer: "Toru Hara",
            director: "Isao Takahata",
            duration: "89",
            score: "97",
            people: []
        )
    ]

    static var example: Film { samples[0] }
}
