//
//  SettingsScreen.swift
//  GhibliSwiftUIApp
//
//  Created by luke howsam on 30/08/2026.
//

import SwiftUI

struct SettingsScreen: View {

    @Environment(FavoritesViewModel.self) private var favoritesViewModel

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    header
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color.clear)
                }

                Section("Favorites") {
                    LabeledContent(
                        "Saved films",
                        value: "\(favoritesViewModel.favoriteIDs.count)"
                    )
                    Button("Clear all favorites", role: .destructive) {
                        favoritesViewModel.clearAll()
                    }
                    .disabled(favoritesViewModel.favoriteIDs.isEmpty)
                }

                Section("About") {
                    LabeledContent("Data", value: "Studio Ghibli API")
                    Link(
                        "ghibliapi.vercel.app",
                        destination: URL(string: "https://ghibliapi.vercel.app")!
                    )
                }
            }
            .navigationTitle("Settings")
        }
    }

    private var header: some View {
        VStack(spacing: Theme.Spacing.sm) {
            Image(systemName: "popcorn.fill")
                .font(.system(size: 44))
                .foregroundStyle(.tint)
                .frame(width: 88, height: 88)
                .background(.tint.opacity(0.12), in: .rect(cornerRadius: Theme.Radius.card))

            Text("Ghibli")
                .font(.title2)
                .bold()

            Text("A little library of Studio Ghibli films.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, Theme.Spacing.lg)
    }
}

#Preview {
    SettingsScreen()
        .environment(FavoritesViewModel.example)
}
