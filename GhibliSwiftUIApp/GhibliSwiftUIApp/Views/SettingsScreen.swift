//
//  SettingsScreen.swift
//  GhibliSwiftUIApp
//
//  Created by luke howsam on 30/08/2026.
//

import SwiftUI

struct SettingsScreen: View {

    let favoritesViewModel: FavoritesViewModel

    var body: some View {
        NavigationStack {
            Form {
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
}

#Preview {
    SettingsScreen(favoritesViewModel: .example)
}
