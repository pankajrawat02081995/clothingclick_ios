//
//  CustomDivider.swift
//  clothingclick
//
//  Created by DavidBisht on 22/04/26.
//

import SwiftUI

struct CustomDivider: View {
    var color: Color
    var lineWidth: CGFloat = 1.0
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: lineWidth)
    }
}

#Preview {
    CustomDivider(color: .gray)
}
