//
//  SlideShowView.swift
//  clothingclick
//
//  Created by DavidBisht on 23/04/26.
//

import SwiftUI

struct SlideShowView<Item: Identifiable, Content: View>: View {
    
    let items: [Item]
    let autoScroll: Bool
    let interval: TimeInterval
    @Binding var currentIndex: Int
    var indexDisplayMode: PageTabViewStyle.IndexDisplayMode = .automatic
    
    let content: (Item) -> Content
   
    @State private var timer: Timer?
    
    var body: some View {
        VStack(spacing: 0) {
            
            TabView(selection: $currentIndex) {
                ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                    content(item)
                        .tag(index)
                }
            }
            .tabViewStyle(
                PageTabViewStyle(
                    indexDisplayMode: items.count > 1 ? indexDisplayMode : .never
                )
            )
            .onAppear {
                startAutoScroll()
            }
            .onDisappear {
                stopAutoScroll()
            }
        }
    }
    
    // MARK: - Auto Scroll
    
    private func startAutoScroll() {
        guard autoScroll, items.count > 1 else { return }
        
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            withAnimation {
                currentIndex = (currentIndex + 1) % items.count
            }
        }
    }
    
    private func stopAutoScroll() {
        timer?.invalidate()
        timer = nil
    }
}

//#Preview {
//    SlideShowView()
//}
