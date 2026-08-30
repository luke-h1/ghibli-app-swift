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
                MoviesScreen(
                    filmsViewModel: filmsViewModel,
                    favoritesViewModel: favoritesViewModel
                )
            }
            Tab("Favorites", systemImage: "heart") {
                FavoritesScreen(
                    filmsViewModel: filmsViewModel,
                    favoritesViewModel: favoritesViewModel
                )
            }
            Tab("Settings", systemImage: "gear") {
                SettingsScreen(favoritesViewModel: favoritesViewModel)
            }
            Tab(role: .search) {
                SearchScreen(
                    filmsViewModel: filmsViewModel,
                    favoritesViewModel: favoritesViewModel
                )
            }
        }
        .onAppear {
            favoritesViewModel.load()
        }
    }
}

#Preview {
    ContentView()
}
