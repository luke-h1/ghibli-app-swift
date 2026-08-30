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
        AsyncImage(url: URL(string: urlPath)) { phase in
            switch phase {
            case .empty:
                Color.gray.opacity(0.2)
            case .success(let image):
                image.resizable().scaledToFill()
            case .failure:
                ZStack {
                    Color.gray.opacity(0.2)
                    Image(systemName: "photo")
                        .foregroundStyle(.secondary)
                }
            @unknown default:
                Color.gray.opacity(0.2)
            }
        }
    }
}

#Preview {
    FilmImageView(urlPath: Film.example.image)
        .frame(width: 150, height: 150)
}
