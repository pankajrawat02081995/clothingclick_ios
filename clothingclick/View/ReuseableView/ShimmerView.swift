//
//  ShimmerView.swift
//  clothingclick
//
//  Created by DavidBisht on 28/04/26.
//

import SwiftUI

struct ShimmerView: View {
    @State private var move: CGFloat = -1

    var body: some View {
        GeometryReader { geo in
            LinearGradient(
                gradient: Gradient(colors: [
                    .clear,
                    .white.opacity(0.6),
                    .clear
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .rotationEffect(.degrees(25))
            .offset(x: geo.size.width * move)
            .onAppear {
                withAnimation(
                    .linear(duration: 1.2)
                    .repeatForever(autoreverses: false)
                ) {
                    move = 1.5
                }
            }
        }
    }
}

#Preview {
    ShimmerView()
}

extension View {
    func shimmer() -> some View {
        self.overlay(ShimmerView().mask(self))
    }
}
