//
//  DefaultsFavoriteStorage.swift
//  GhibliSwiftUIApp
//
//  Created by luke howsam on 30/08/2026.
//

import Foundation

struct DefaultsFavoriteStorage: FavoriteStorage {

    private let favoritesKey = "FavoriteFilms"

    func load() -> Set<String> {
        let array = UserDefaults.standard.stringArray(forKey: favoritesKey)

        return Set(array ?? [])
    }

    func save(favoriteIDs: Set<String>) {
        UserDefaults.standard.set(Array(favoriteIDs), forKey: favoritesKey)
    }
}
