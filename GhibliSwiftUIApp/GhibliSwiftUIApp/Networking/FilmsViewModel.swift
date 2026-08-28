//
//  FilmsViewModel.swift
//  GhibliSwiftUIApp
//
//  Created by luke howsam on 28/08/2026.
//

import Foundation
import Observation

enum ApiError: LocalizedError {
    case invalidURL
    case invalidResponse
    case decoding(Error)
    case networkError(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid response from server"
        case .decoding(let error):
            return "Failed to decode JSON: \(error.localizedDescription)"
        case .networkError(let error):
            return "A network error occurred: \(error.localizedDescription)"
        }
    }
}

@Observable
class FilmsViewModel {
    enum State: Equatable {
        case idle
        case loading
        case loaded([Film])
        case error(String)
    }

    var state: State = .idle
    var films: [Film] = []

    func fetch() async {
        guard state == .idle else { return }
        state = .loading
        do {
            let films = try await fetchFilms()
            
            self.state = .loaded(films)
        } catch let error as ApiError{
            self.state = .error(error.localizedDescription)
        } catch {
            self.state = .error("unknown error")
        }
    }

    private func fetchFilms() async throws -> [Film] {
        guard let url = URL(string: "https://ghibliapi.vercel.app/films") else {
            throw ApiError.invalidURL
        }

        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode)
            else {
                throw ApiError.invalidResponse
            }

            films = try JSONDecoder().decode([Film].self, from: data)
            return films
        } catch let error as DecodingError {
            throw ApiError.decoding(error)
        } catch let error as URLError {
            throw ApiError.networkError(error)
        }
    }
}

