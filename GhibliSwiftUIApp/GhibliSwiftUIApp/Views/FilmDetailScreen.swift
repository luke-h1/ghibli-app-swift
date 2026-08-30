//
//  FilmDetailScreen.swift
//  GhibliSwiftUIApp
//
//  Created by luke howsam on 30/08/2026.
//

import SwiftUI

struct FilmDetailScreen: View {
    let film: Film

    @Environment(FavoritesViewModel.self) private var favoritesViewModel
    @State private var viewModel = FilmDetailViewModel()

    private var isFavorite: Bool {
        favoritesViewModel.isFavorite(filmID: film.id)
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Theme.Spacing.lg) {
                hero

                VStack(alignment: .leading, spacing: Theme.Spacing.lg) {
                    Text(film.description)

                    charactersSection
                }
                .padding(.horizontal, Theme.Spacing.md)
                .padding(.bottom, Theme.Spacing.lg)
            }
        }
        .scrollIndicators(.hidden)
        .ignoresSafeArea(edges: .top)
        .task(id: film) {
            await viewModel.fetch(for: film)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                FavoriteButton(isFavorite: isFavorite, prominent: true) {
                    favoritesViewModel.toggleFavorite(filmID: film.id)
                }
            }
        }
        .toolbarBackground(.hidden, for: .navigationBar)
    }

    private var hero: some View {
        Color.clear
            .aspectRatio(Theme.heroAspectRatio, contentMode: .fit)
            .overlay {
                FilmImageView(urlPath: film.bannerImage)
            }
            .overlay { Theme.scrim }
            .overlay(alignment: .bottomLeading) {
                VStack(alignment: .leading, spacing: Theme.Spacing.sm) {
                    Text(film.title)
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.white)

                    Text("Directed by \(film.director)")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.9))

                    HStack(spacing: Theme.Spacing.sm) {
                        StatChip(icon: "calendar", text: film.releaseDate)
                        StatChip(icon: "clock", text: "\(film.duration) min")
                        StatChip(icon: "star.fill", text: "\(film.score)%")
                    }
                    .padding(.top, Theme.Spacing.xs)
                }
                .padding(Theme.Spacing.md)
            }
    }

    @ViewBuilder
    private var charactersSection: some View {
        Text("Characters")
            .font(.title2)
            .bold()

        switch viewModel.state {
        case .idle, .loading:
            ProgressView()
                .frame(maxWidth: .infinity)
                .padding(.vertical, Theme.Spacing.lg)

        case .error(let error):
            Text(error)
                .font(.subheadline)
                .foregroundStyle(.secondary)

        case .loaded(let people):
            if people.isEmpty {
                Text("No character info available.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            } else {
                LazyVGrid(
                    columns: [GridItem(.adaptive(minimum: 120), spacing: Theme.Spacing.sm)],
                    alignment: .leading,
                    spacing: Theme.Spacing.sm
                ) {
                    ForEach(people) { person in
                        Text(person.name)
                            .font(.subheadline)
                            .lineLimit(1)
                            .padding(.horizontal, Theme.Spacing.md)
                            .padding(.vertical, Theme.Spacing.sm)
                            .frame(maxWidth: .infinity)
                            .background(.thinMaterial, in: .capsule)
                    }
                }
            }
        }
    }
}

private struct StatChip: View {
    let icon: String
    let text: String

    var body: some View {
        Label(text, systemImage: icon)
            .font(.caption)
            .bold()
            .foregroundStyle(.white)
            .padding(.horizontal, Theme.Spacing.sm)
            .padding(.vertical, Theme.Spacing.xs)
            .background(.white.opacity(0.18), in: .capsule)
    }
}

#Preview {
    NavigationStack {
        FilmDetailScreen(film: .example)
    }
    .environment(FavoritesViewModel.example)
}
