//
//  FilmListView.swift
//  GhibliSwiftUIApp
//
//  Created by luke howsam on 28/08/2026.
//

import SwiftUI

struct FilmListView: View {

    @State private var filmsViewModel = FilmsViewModel()

    var body: some View {
        NavigationStack {

            switch filmsViewModel.state {
            case .idle:
                Text("No Films yet")
            case .loading:
                ProgressView {
                    Text("Loading...")
                }

            case .loaded(let array):
                List(filmsViewModel.films) {
                    Text($0.title)
                }

            case .error(let error):
                Text(error)
                    .foregroundStyle(.red)
            }
        }.task {
            await filmsViewModel.fetch()
        }
    }
}

#Preview {
    FilmListView()
}
