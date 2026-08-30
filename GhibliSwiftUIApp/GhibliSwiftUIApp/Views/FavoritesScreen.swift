//
//  FavoritesScreen.swift
//  GhibliSwiftUIApp
//
//  Created by luke howsam on 30/08/2026.
//

import SwiftUI

struct FavoritesScreen: View {

    let filmsViewModel: FilmsViewModel
    let favoritesViewModel: FavoritesViewModel

    var films: [Film] {
        guard case .loaded(let films) = filmsViewModel.state else {
            return []
        }
        return films.filter { favoritesViewModel.isFavorite(filmID: $0.id) }
    }

    var body: some View {
        NavigationStack {
            Group {
                if films.isEmpty {
                    ContentUnavailableView(
                        "No favorites yet",
                        systemImage: "heart",
                        description: Text("Films you favorite will show up here.")
                    )
                } else {
                    FilmListView(
                        films: films,
                        favoritesViewModel: favoritesViewModel
                    )
                }
            }
            .navigationTitle("Favorites")
        }
    }
}

#Preview {
    FavoritesScreen(
        filmsViewModel: .example,
        favoritesViewModel: .example
    )
}
