//
//  FilmDetailViewModel.swift
//  GhibliSwiftUIApp
//
//  Created by luke howsam on 30/08/2026.
//

import Foundation
import Observation

@Observable
class FilmDetailViewModel {
    enum State: Equatable {
        case idle
        case loading
        case loaded([Person])
        case error(String)
    }

    var state: State = .idle

    private let service: GhibliService

    init(service: GhibliService = DefaultGhibliService()) {
        self.service = service
    }

    func fetch(for film: Film) async {
        guard state != .loading else {
            return
        }
        state = .loading

        var loadedPeople: [Person] = []

        // Some films link the whole `/people/` collection rather than
        // individual characters
        let personURLs = film.people.filter { urlString in
            URL(string: urlString)?.lastPathComponent.lowercased() != "people"
        }

        do {
            try await withThrowingTaskGroup(of: Person.self) { group in
                for personInfoURL in personURLs {
                    group.addTask {
                        try await self.service.fetchPerson(from: personInfoURL)
                    }
                }

                for try await person in group {
                    loadedPeople.append(person)
                }
            }

            state = .loaded(loadedPeople)
        } catch let error as ApiError {
            self.state = .error(error.localizedDescription)
        } catch {
            self.state = .error("unknown error")
        }
    }
}
