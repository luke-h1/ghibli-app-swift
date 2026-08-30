//
//  ApiError.swift
//  GhibliSwiftUIApp
//
//  Created by luke howsam on 30/08/2026.
//

import Foundation

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
