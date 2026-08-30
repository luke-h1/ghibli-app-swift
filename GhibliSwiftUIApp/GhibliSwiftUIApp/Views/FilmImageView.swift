//
//  FilmImageView.swift
//  GhibliSwiftUIApp
//
//  Created by luke howsam on 30/08/2026.
//

import SwiftUI

struct FilmImageView: View {

    let urlPath: String

    var body: some View {
        AsyncImage(url: URL(string: urlPath)) {
            phase in
            switch phase {
            case .empty: Color.gray
            case .success(let image):
                image.resizable().scaledToFill()
            case .failure(_):
                Text("Could not get image")

            @unknown default:
                fatalError()
            }
        }.frame(height: 200)
    }
}
