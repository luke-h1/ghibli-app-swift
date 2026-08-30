//
//  MoviesScreen.swift
//  GhibliSwiftUIApp
//
//  Created by luke howsam on 30/08/2026.
//

import SwiftUI

struct MoviesScreen: View {

    let filmsViewModel: FilmsViewModel
    let favoritesViewModel: FavoritesViewModel

    var body: some View {
        NavigationStack {
            Group {
                switch filmsViewModel.state {
                case .idle, .loading:
                    LoadingFeed()

                case .loaded(let films):
                    FilmListView(
                        films: films,
                        favoritesViewModel: favoritesViewModel
                    )

                case .error(let error):
                    ContentUnavailableView(
                        "Something went wrong",
                        systemImage: "exclamationmark.triangle",
                        description: Text(error)
                    )
                }
            }
            .navigationTitle("Ghibli")
        }
        .task {
            await filmsViewModel.fetch()
        }
    }
}

private struct LoadingFeed: View {
    var body: some View {
        ScrollView {
            LazyVStack(spacing: Theme.Spacing.lg) {
                ForEach(0..<3, id: \.self) { _ in
                    RoundedRectangle(cornerRadius: Theme.Radius.card)
                        .fill(.quaternary)
                        .aspectRatio(Theme.heroAspectRatio, contentMode: .fit)
                }
            }
            .padding(Theme.Spacing.md)
        }
        .scrollDisabled(true)
        .redacted(reason: .placeholder)
        .accessibilityLabel("Loading films")
    }
}

#Preview {
    MoviesScreen(
        filmsViewModel: .example,
        favoritesViewModel: .example
    )
}
