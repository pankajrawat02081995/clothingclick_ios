//
//  SlidingSwitch.swift
//  clothingclick
//
//  Created by DavidBisht on 06/05/26.
//

import SwiftUI

struct SlidingSwitch: View {
    @Binding var isOn: Bool
    
    private let width: CGFloat = 29
    private let height: CGFloat = 20
    private let knobWidth: CGFloat = 15
    private let knobHeight: CGFloat = 20
    private let isOnColor: Color = Color.black
    private let isOffColor: Color = Color.white
    private let strokeColor: Color = Color.black
    private let knobOnColor: Color = Color.white
    private let knobOffColor: Color = Color.black
    
    @State private var dragOffset: CGFloat = 0
    @State private var isDragging = false

    var body: some View {
        let maxOffset = width - knobWidth
        
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 5)
                .fill(isOn ? isOnColor : isOffColor)
                .stroke(strokeColor, lineWidth: 1)
            RoundedRectangle(cornerRadius: 4)
                .fill(isOn ? knobOnColor : knobOffColor)
                .padding(2)
                .frame(width: knobWidth, height: knobHeight)
                .offset(x: currentOffset(maxOffset: maxOffset))
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            isDragging = true
                            
                            let baseOffset = isOn ? maxOffset : 0
                            let newOffset = baseOffset + value.translation.width
                            
                            dragOffset = min(max(0, newOffset), maxOffset)
                        }
                        .onEnded { value in
                            let threshold = maxOffset / 2
                            
                            withAnimation(.easeInOut) {
                                isOn = dragOffset > threshold
                                dragOffset = 0
                                isDragging = false
                            }
                        }
                )
        }
        .frame(width: width, height: height)
        .padding(2)
        .contentShape(Rectangle())
        .onTapGesture {
            withAnimation(.easeInOut) {
                isOn.toggle()
            }
        }
    }
    
    private func currentOffset(maxOffset: CGFloat) -> CGFloat {
        if isDragging {
            return dragOffset
        } else {
            return isOn ? maxOffset : 0
        }
    }
}
