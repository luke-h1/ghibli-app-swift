//
//  MockGhibliService.swift
//  GhibliSwiftUIApp
//
//  Created by luke howsam on 29/08/2026.
//

import Foundation

struct MockGhibliService: GhibliService {

    private struct SampleData: Decodable {
        let films: [Film]
        let people: [Person]
    }

    private func loadSampleData() throws -> SampleData {
        guard
            let url = Bundle.main.url(
                forResource: "SampleData",
                withExtension: "json"
            )
        else {
            throw ApiError.invalidURL
        }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(SampleData.self, from: data)
        } catch let error as DecodingError {
            throw ApiError.decoding(error)
        } catch {
            throw ApiError.networkError(error)
        }
    }

    func fetchFilms() async throws -> [Film] {
        let data = try loadSampleData()
        return data.films
    }

    // MARK: test only
    func fetchFilm() async throws -> Film {
        let data = try loadSampleData()

        return data.films.first!
    }

    func fetchPerson(from URLString: String) async throws -> Person {
        let data = try loadSampleData()

        return data.people.first!
    }
}
