//
//  CustomSlider.swift
//  clothingclick
//
//  Created by DavidBisht on 08/05/26.
//

import SwiftUI

struct CustomSlider<
    Value: BinaryFloatingPoint,
    Track: View,
    Fill: View,
    Thumb: View
>: View {
    
    @Binding var value: Value
    
    let range: ClosedRange<Value>
    
    /// Increment amount
    /// Examples:
    /// 1     -> 0,1,2,3
    /// 5     -> 0,5,10
    /// 0.5   -> 0,0.5,1
    let step: Value
    
    /// true  -> integer output
    /// false -> decimal output
    let useIntegerStep: Bool
    
    let track: () -> Track
    let fill: () -> Fill
    let thumb: () -> Thumb
    
    private let thumbSize: CGFloat = 24
    
    init(
        value: Binding<Value>,
        range: ClosedRange<Value>,
        step: Value = 1,
        useIntegerStep: Bool = true,
        @ViewBuilder track: @escaping () -> Track,
        @ViewBuilder fill: @escaping () -> Fill,
        @ViewBuilder thumb: @escaping () -> Thumb
    ) {
        self._value = value
        self.range = range
        self.step = step
        self.useIntegerStep = useIntegerStep
        self.track = track
        self.fill = fill
        self.thumb = thumb
    }
    
    // MARK: - Progress
    
    private var percentage: CGFloat {
        CGFloat(
            (value - range.lowerBound) /
            (range.upperBound - range.lowerBound)
        )
    }
    
    var body: some View {
        
        GeometryReader { geometry in
            
            let totalWidth = geometry.size.width
            let availableWidth = totalWidth - thumbSize
            
            let thumbX = availableWidth * percentage
            
            ZStack(alignment: .leading) {
                
                // MARK: Track
                
                track()
                    .frame(height: 10)
                
                // MARK: Fill
                
                fill()
                    .frame(width: thumbX + thumbSize / 2)
                    .frame(height: 10)
                
                // MARK: Thumb
                
                thumb()
                    .frame(width: thumbSize, height: thumbSize)
                    .offset(x: thumbX)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                
                                // Keep thumb inside bounds
                                let x = min(
                                    max(0, gesture.location.x - thumbSize / 2),
                                    availableWidth
                                )
                                
                                // 0 -> 1
                                let percent = x / availableWidth
                                
                                // Raw slider value
                                let rawValue =
                                Double(range.lowerBound) +
                                Double(range.upperBound - range.lowerBound) * percent
                                
                                // Apply step increment
                                var steppedValue =
                                (rawValue / Double(step)).rounded() * Double(step)
                                
                                // Integer mode
                                if useIntegerStep {
                                    steppedValue = steppedValue.rounded()
                                }
                                
                                // Clamp
                                steppedValue = min(
                                    max(Double(range.lowerBound), steppedValue),
                                    Double(range.upperBound)
                                )
                                
                                value = Value(steppedValue)
                            }
                    )
            }
        }
        .frame(height: thumbSize)
    }
}
