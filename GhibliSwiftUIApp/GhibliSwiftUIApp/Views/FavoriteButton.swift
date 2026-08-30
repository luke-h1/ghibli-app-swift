//
//  FavoriteButton.swift
//  GhibliSwiftUIApp
//
//  Created by luke howsam on 30/08/2026.
//

import SwiftUI

struct FavoriteButton: View {

    let isFavorite: Bool
    var prominent: Bool = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: isFavorite ? "heart.fill" : "heart")
                .font(.headline)
                .foregroundStyle(isFavorite ? .pink : (prominent ? .white : .primary))
                .frame(width: 44, height: 44)
                .background(.ultraThinMaterial, in: .circle)
                .contentTransition(.symbolEffect(.replace))
        }
        .buttonStyle(.plain)
        .sensoryFeedback(.impact(weight: .light), trigger: isFavorite)
        .accessibilityLabel(isFavorite ? "Remove from favorites" : "Add to favorites")
    }
}

#Preview {
    HStack(spacing: 16) {
        FavoriteButton(isFavorite: false) {}
        FavoriteButton(isFavorite: true) {}
    }
    .padding()
    .background(.black)
}
