//
//  Theme.swift
//  GhibliSwiftUIApp
//
//  Created by luke howsam on 30/08/2026.
//

import SwiftUI

enum Theme {
    enum Spacing {
        static let xs: CGFloat = 4
        static let sm: CGFloat = 8
        static let md: CGFloat = 16
        static let lg: CGFloat = 24
    }

    enum Radius {
        static let card: CGFloat = 20
        static let control: CGFloat = 14
    }

    static let heroAspectRatio: CGFloat = 3.0 / 2.0

    static let cardShadow = Color.black.opacity(0.18)

    static let scrim = LinearGradient(
        colors: [.clear, .black.opacity(0.15), .black.opacity(0.75)],
        startPoint: .top,
        endPoint: .bottom
    )
}
