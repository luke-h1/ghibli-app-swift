//
//  SearchScreen.swift
//  GhibliSwiftUIApp
//
//  Created by luke howsam on 30/08/2026.
//

import SwiftUI

struct SearchScreen: View {

    let filmsViewModel: FilmsViewModel
    let favoritesViewModel: FavoritesViewModel

    @State private var text: String = ""

    private var allFilms: [Film] {
        if case .loaded(let films) = filmsViewModel.state {
            return films
        }
        return []
    }

    private var results: [Film] {
        guard !text.isEmpty else { return allFilms }
        return allFilms.filter {
            $0.title.localizedCaseInsensitiveContains(text)
                || $0.director.localizedCaseInsensitiveContains(text)
        }
    }

    var body: some View {
        NavigationStack {
            Group {
                if results.isEmpty {
                    ContentUnavailableView.search(text: text)
                } else {
                    FilmListView(
                        films: results,
                        favoritesViewModel: favoritesViewModel
                    )
                }
            }
            .navigationTitle("Search")
            .searchable(text: $text, prompt: "Search films or directors")
        }
    }
}

#Preview {
    SearchScreen(
        filmsViewModel: .example,
        favoritesViewModel: .example
    )
}
