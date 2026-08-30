//
//  FilmListView.swift
//  GhibliSwiftUIApp
//
//  Created by luke howsam on 28/08/2026.
//

import SwiftUI

struct FilmListView: View {

    let films: [Film]
    let favoritesViewModel: FavoritesViewModel

    var body: some View {
        ScrollView {
            LazyVStack(spacing: Theme.Spacing.lg) {
                ForEach(films) { film in
                    cell(for: film)
                }
            }
            .padding(Theme.Spacing.md)
        }
        .scrollIndicators(.hidden)
        .navigationDestination(for: Film.self) { film in
            FilmDetailScreen(film: film, favoritesViewModel: favoritesViewModel)
        }
    }

    private func cell(for film: Film) -> some View {
        ZStack(alignment: .topTrailing) {
            NavigationLink(value: film) {
                FilmCard(film: film)
            }
            .buttonStyle(.plain)

            FavoriteButton(
                isFavorite: favoritesViewModel.isFavorite(filmID: film.id),
                prominent: true
            ) {
                favoritesViewModel.toggleFavorite(filmID: film.id)
            }
            .padding(Theme.Spacing.sm)
        }
        .scrollTransition { content, phase in
            content
                .opacity(phase.isIdentity ? 1 : 0)
                .scaleEffect(phase.isIdentity ? 1 : 0.94)
        }
    }
}

#Preview {
    NavigationStack {
        FilmListView(films: Film.samples, favoritesViewModel: .example)
    }
}
