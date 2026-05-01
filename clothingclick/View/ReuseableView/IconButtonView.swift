//
//  IconButtonView.swift
//  clothingclick
//
//  Created by DavidBisht on 27/04/26.
//

import SwiftUI

struct IconButtonView: View {
    
    let image: Image
    let title: String?
    let action: () -> Void
    
    var cornerRadius: CGFloat = 5
    var borderColor: Color = AppColor.borderColor
    var padding: CGFloat = 10
    
    var body: some View {
        Button(action: action) {
            HStack {
                image
                    .scaledToFit()
                    .padding(.vertical,padding)
                if let title = title {
                    Text(title)
                        .font(AppFont.regular.font(size: 13))
                        .foregroundStyle(AppColor.blackColor)
                }
            }
            .padding(.horizontal,padding)
            .frame(maxWidth: .infinity)
            .overlay {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: 1)
            }
        }
    }
}

#Preview {
    IconButtonView(image: Image(.star), title: nil) {
        print("action")
    }
}
