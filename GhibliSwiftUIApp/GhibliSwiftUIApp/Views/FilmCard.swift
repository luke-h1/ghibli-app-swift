//
//  FilmCard.swift
//  GhibliSwiftUIApp
//
//  Created by luke howsam on 30/08/2026.
//

import SwiftUI

struct FilmCard: View {

    let film: Film

    var body: some View {
        Color.clear
            .aspectRatio(Theme.heroAspectRatio, contentMode: .fit)
            .overlay {
                FilmImageView(urlPath: film.bannerImage)
            }
            .overlay { Theme.scrim }
            .overlay(alignment: .bottomLeading) {
                VStack(alignment: .leading, spacing: Theme.Spacing.xs) {
                    Text(film.title)
                        .font(.title2)
                        .bold()
                        .foregroundStyle(.white)

                    HStack(spacing: Theme.Spacing.md) {
                        Label(film.releaseDate, systemImage: "calendar")
                        Label("\(film.score)%", systemImage: "star.fill")
                        Label("\(film.duration) min", systemImage: "clock")
                    }
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.9))
                }
                .padding(Theme.Spacing.md)
            }
            .clipShape(.rect(cornerRadius: Theme.Radius.card))
            .overlay {
                RoundedRectangle(cornerRadius: Theme.Radius.card)
                    .strokeBorder(.white.opacity(0.08), lineWidth: 1)
            }
            .shadow(color: Theme.cardShadow, radius: 12, y: 6)
            .accessibilityElement(children: .combine)
            .accessibilityLabel("\(film.title), \(film.releaseDate)")
    }
}

#Preview {
    FilmCard(film: .example)
        .padding()
}
