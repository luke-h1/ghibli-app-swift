//
//  FavoritesViewModel.swift
//  GhibliSwiftUIApp
//
//  Created by luke howsam on 30/08/2026.
//

import Foundation
import Observation

@Observable
class FavoritesViewModel {
    private(set) var favoriteIDs: Set<String> = []

    private let service: FavoriteStorage

    init(service: FavoriteStorage = DefaultsFavoriteStorage()) {
        self.service = service
    }

    func load() {
        favoriteIDs = service.load()
    }

    func save() {
        service.save(favoriteIDs: favoriteIDs)
    }

    func toggleFavorite(filmID: String) {
        if favoriteIDs.contains(filmID) {
            favoriteIDs.remove(filmID)
        } else {
            favoriteIDs.insert(filmID)
        }
        save()
    }

    func isFavorite(filmID: String) -> Bool {
        favoriteIDs.contains(filmID)
    }

    func clearAll() {
        favoriteIDs = []
        save()
    }
}

extension FavoritesViewModel {
    static var example: FavoritesViewModel {
        let vm = FavoritesViewModel(
            service: MockFavoriteStorage(favoriteIDs: [Film.samples[0].id])
        )
        vm.load()
        return vm
    }
}
