//
//  FilmsViewModel.swift
//  GhibliSwiftUIApp
//
//  Created by luke howsam on 28/08/2026.
//

import Foundation
import Observation



@Observable
class FilmsViewModel {
    enum State: Equatable {
        case idle
        case loading
        case loaded([Film])
        case error(String)
    }

    private let service: GhibliService

    var state: State = .idle
    var films: [Film] = []

    init(service: GhibliService = DefaultGhibliService()) {
        self.service = service
    }

    func fetch() async {
        guard state == .idle else { return }
        state = .loading
        do {
            let films = try await service.fetchFilms()

            self.state = .loaded(films)
        } catch let error as ApiError {
            self.state = .error(error.localizedDescription)
        } catch {
            self.state = .error("unknown error")
        }
    }

}
