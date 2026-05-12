//
//  InfoOverlayView.swift
//  clothingclick
//
//  Created by DavidBisht on 06/05/26.
//

import SwiftUI

// MARK: - Position Enum
enum InfoPosition {
    case top, bottom, leading, trailing
}

// MARK: - Triangle Shape
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

// MARK: - Frame PreferenceKey
struct FramePreferenceKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

// MARK: - Tooltip View
struct InfoOverlayView: View {

    var title: String
    var subtitle: String
    var buttonTitle: String
    var position: InfoPosition
    var targetFrame: CGRect
    var screenFrame: CGRect
    var action: () -> Void

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Background
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture { action() }

                content
                    .position(calculatePosition(in: geo))
                    .animation(.easeInOut(duration: 0.2), value: targetFrame)
            }
        }
    }

    // MARK: Content
    private var content: some View {
        VStack(spacing: 0) {

            if position == .bottom {
                tail
            }

            mainBox

            if position == .top {
                tail
            }
        }
    }

    // MARK: Box UI
    private var mainBox: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.headline)

            Text(subtitle)
                .font(.subheadline)
                .multilineTextAlignment(.center)

            Button(buttonTitle, action: action)
                .padding(.top, 6)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 8)
    }

    // MARK: Tail
    private var tail: some View {
        Triangle()
            .fill(Color.white)
            .frame(width: 18, height: 10)
            .rotationEffect(rotationAngle)
    }

    private var rotationAngle: Angle {
        switch position {
        case .top: return .degrees(180)
        case .bottom: return .degrees(0)
        case .leading: return .degrees(90)
        case .trailing: return .degrees(-90)
        }
    }

    // MARK: Position Fix (IMPORTANT)
    private func calculatePosition(in geo: GeometryProxy) -> CGPoint {

        let safeAreaTop = screenFrame.minY

        switch position {

        case .top:
            return CGPoint(
                x: targetFrame.minX + geo.size.width/2,
                y: targetFrame.minY - 60
            )

        case .bottom:
            return CGPoint(
                x: targetFrame.minX + geo.size.width/2,
                y: targetFrame.maxY + 60
            )

        case .leading:
            return CGPoint(
                x: targetFrame.minX - 120,
                y: targetFrame.midY
            )

        case .trailing:
            return CGPoint(
                x: targetFrame.maxX + 120,
                y: targetFrame.midY
            )
        }
    }
}

// MARK: - Demo Screen
struct ContentView: View {

    @State private var targetFrame: CGRect = .zero
    @State private var screenFrame: CGRect = .zero
    @State private var show = false
    @State private var position: InfoPosition = .top

    var body: some View {
        ZStack {

            VStack(spacing: 30) {

                Spacer()

                Button("Tap Me") {
                    withAnimation {
                        show = true
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .background(
                    GeometryReader { geo in
                        Color.clear
                            .preference(
                                key: FramePreferenceKey.self,
                                value: geo.frame(in: .global)
                            )
                    }
                )

                Picker("Position", selection: $position) {
                    Text("Top").tag(InfoPosition.top)
                    Text("Bottom").tag(InfoPosition.bottom)
                    Text("Leading").tag(InfoPosition.leading)
                    Text("Trailing").tag(InfoPosition.trailing)
                }
                .pickerStyle(.segmented)
                .padding()

                Spacer()
            }

            // Overlay
            if show {
                InfoOverlayView(
                    title: "Tooltip Title",
                    subtitle: "This tooltip is properly aligned now",
                    buttonTitle: "Got it",
                    position: position,
                    targetFrame: targetFrame,
                    screenFrame: screenFrame
                ) {
                    withAnimation {
                        show = false
                    }
                }
            }
        }

        // Capture button frame
        .onPreferenceChange(FramePreferenceKey.self) {
            targetFrame = $0
        }

        // Capture screen frame
        .background(
            GeometryReader { geo in
                Color.clear.onAppear {
                    screenFrame = geo.frame(in: .global)
                }
            }
        )
    }
}

#Preview {
    ContentView()
}
