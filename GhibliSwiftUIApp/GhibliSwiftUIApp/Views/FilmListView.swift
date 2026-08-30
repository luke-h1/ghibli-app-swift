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
        List(films) { film in
            NavigationLink(value: film) {
                FilmRow(film: film, favoritesViewModel: favoritesViewModel)
            }
            .swipeActions(edge: .trailing) {
                let isFavorite = favoritesViewModel.isFavorite(filmID: film.id)
                Button {
                    favoritesViewModel.toggleFavorite(filmID: film.id)
                } label: {
                    Label(
                        isFavorite ? "Unfavorite" : "Favorite",
                        systemImage: isFavorite ? "heart.slash" : "heart"
                    )
                }
                .tint(.pink)
            }
        }
        .listStyle(.plain)
        .navigationDestination(for: Film.self) { film in
            FilmDetailScreen(film: film, favoritesViewModel: favoritesViewModel)
        }
    }
}

private struct FilmRow: View {

    let film: Film
    let favoritesViewModel: FavoritesViewModel

    var body: some View {
        HStack(spacing: 12) {
            FilmImageView(urlPath: film.image)
                .frame(width: 70, height: 70)
                .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 4) {
                Text(film.title)
                    .font(.headline)
                Text(film.releaseDate)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            if favoritesViewModel.isFavorite(filmID: film.id) {
                Image(systemName: "heart.fill")
                    .foregroundStyle(.pink)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    NavigationStack {
        FilmListView(films: Film.samples, favoritesViewModel: .example)
    }
}
