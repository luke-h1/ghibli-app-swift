//
//  MockFavoriteStorage.swift
//  GhibliSwiftUIApp
//
//  Created by luke howsam on 30/08/2026.
//

import Foundation

final class MockFavoriteStorage: FavoriteStorage {

    private(set) var storedFavoriteIDs: Set<String>

    private(set) var loadCallCount = 0
    private(set) var saveCallCount = 0

    init(favoriteIDs: Set<String> = []) {
        self.storedFavoriteIDs = favoriteIDs
    }

    func load() -> Set<String> {
        loadCallCount += 1
        return storedFavoriteIDs
    }

    func save(favoriteIDs: Set<String>) {
        saveCallCount += 1
        storedFavoriteIDs = favoriteIDs
    }
}
