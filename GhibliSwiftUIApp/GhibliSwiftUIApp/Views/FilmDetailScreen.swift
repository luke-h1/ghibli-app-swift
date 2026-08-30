//
//  FilmDetailScreen.swift
//  GhibliSwiftUIApp
//
//  Created by luke howsam on 30/08/2026.
//

import Foundation
import SwiftUI

struct FilmDetailScreen: View {
    let film: Film
    let favoritesViewModel: FavoritesViewModel

    @State private var viewModel = FilmDetailViewModel()

    private var isFavorite: Bool {
        favoritesViewModel.isFavorite(filmID: film.id)
    }

    var body: some View {
        ScrollView {
            FilmImageView(urlPath: film.bannerImage)
                .frame(height: 300)
                .containerRelativeFrame(.horizontal)
                .clipped()

            VStack(alignment: .leading, spacing: 12) {
                Text(film.title)
                    .font(.title)
                    .bold()

                HStack(spacing: 16) {
                    Label(film.releaseDate, systemImage: "calendar")
                    Label("\(film.duration) min", systemImage: "clock")
                    Label(film.score, systemImage: "star.fill")
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)

                Text("Directed by \(film.director)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Text(film.description)

                Divider()

                Text("Characters").font(.title3).bold()

                switch viewModel.state {
                case .idle:
                    EmptyView()
                case .loading:
                    ProgressView {
                        Text("Loading...")
                    }
                case .error(let error):
                    Text(error)
                        .foregroundStyle(.red)
                case .loaded(let people):
                    if people.isEmpty {
                        Text("No character info available.")
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(people) { person in
                            Text(person.name)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .task(id: film) {
            await viewModel.fetch(for: film)
        }
        .navigationTitle(film.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    favoritesViewModel.toggleFavorite(filmID: film.id)
                } label: {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundStyle(.pink)
                }
                .accessibilityLabel(isFavorite ? "Unfavorite" : "Favorite")
            }
        }
    }
}

#Preview {
    NavigationStack {
        FilmDetailScreen(film: .example, favoritesViewModel: .example)
    }
}
