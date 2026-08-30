//
//  ContentView.swift
//  GhibliSwiftUIApp
//
//  Created by luke howsam on 28/08/2026.
//

import SwiftUI

struct ContentView: View {

    @State private var filmsViewModel = FilmsViewModel()
    @State private var favoritesViewModel = FavoritesViewModel()

    var body: some View {
        TabView {
            Tab("Movies", systemImage: "popcorn") {
                MoviesScreen()
            }
            Tab("Favorites", systemImage: "heart") {
                FavoritesScreen()
            }
            Tab("Settings", systemImage: "gear") {
                SettingsScreen()
            }
            Tab(role: .search) {
                SearchScreen()
            }
        }
        .environment(filmsViewModel)
        .environment(favoritesViewModel)
        .onAppear {
            favoritesViewModel.load()
        }
    }
}

#Preview {
    ContentView()
}
