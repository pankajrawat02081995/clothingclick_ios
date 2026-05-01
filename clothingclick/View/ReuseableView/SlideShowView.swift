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
    var customIndexDisplayMode: Bool = false
    
    let content: (Item) -> Content
   
    @State private var timer: Timer?
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .bottomLeading) {
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
                // Indicator
                HStack(spacing: 4) {
                    ForEach(0..<items.count, id: \.self) { index in
                        Circle()
                            .fill(index == currentIndex ? AppColor.whiteColor : AppColor.grayColor)
                            .overlay(
                                Circle().stroke(AppColor.blackColor, lineWidth: 1)
                            )
                            .frame(width: 6, height: 6)
                    }
                }
                .padding(8)
                .allowsHitTesting(false)
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
