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

    @State private var viewModel = FilmDetailViewModel(
        service: DefaultGhibliService()
    )

    var body: some View {
        VStack(alignment: .leading) {
            ScrollView {

                FilmImageView(urlPath: film.bannerImage).frame(height: 300)
                    .containerRelativeFrame(.horizontal)
                VStack(alignment: .leading) {
                    Text(film.title)
                    Divider()

                    Text("Characters").font(.title3)

                    switch viewModel.state {
                    case .idle:
                        Text("No Films yet")
                    case .loading:
                        ProgressView {
                            Text("Loading...")
                        }

                    case .error(let error):
                        Text(error)
                            .foregroundStyle(.red)

                    case .loaded(let people):
                        ForEach(people) { person in
                            Text(person.name)
                        }
                    }
                }
                .padding()
            }
        }
        .task(id: film) {
            await viewModel.fetch(for: film)
        }
        .navigationBarTitle(film.title)
    }
}
