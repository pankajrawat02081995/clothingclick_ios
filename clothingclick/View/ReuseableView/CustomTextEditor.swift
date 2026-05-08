//
//  CustomTextEditor.swift
//  clothingclick
//
//  Created by DavidBisht on 07/05/26.
//

import SwiftUI

struct CustomTextEditor: View {
    
    @Binding var text: String
    @FocusState.Binding var isFocused: Bool
    var placeholder: String = "Enter text..."
    var cornerRadius: CGFloat = 12
    var strokeLineWidth: CGFloat = 1
    var placeholderColor: Color = Color.gray
    var textColor: Color = Color.black
    var backgroundColor: Color = Color.gray.opacity(0.12)
    var strokeColor: Color = Color.gray.opacity(0.3)
    var uiFont: UIFont = .systemFont(ofSize: 13, weight: .regular)
    var minHeight: CGFloat
    var maxHeight: CGFloat
 
    @State private var dynamicHeight: CGFloat = 10
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            // Placeholder
            if text.isEmpty {
                Text(placeholder)
                    .font(Font(uiFont))
                    .foregroundColor(placeholderColor)
                    .padding(.horizontal, cornerRadius+5)
                    .frame(height: dynamicHeight)
            }
            
            // TextEditor
            TextEditor(text: $text)
                .font(Font(uiFont))
                .foregroundColor(textColor)
                .scrollContentBackground(.hidden)
                .padding(cornerRadius)
                .frame(height: dynamicHeight)
                .background(Color.clear)
                .focused($isFocused)
                .onChange(of: text) { _,_ in
                    if (minHeight != maxHeight) {
                        recalcHeight()
                    }
                }
        }
        .onAppear {
            if minHeight != maxHeight {
                recalcHeight()
            } else {
                dynamicHeight = maxHeight
            }
        }
        .background(
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(backgroundColor)
        )
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(strokeColor, lineWidth: strokeLineWidth)
        )
    }
    
    private func recalcHeight() {
           let size = CGSize(width: UIScreen.main.bounds.width - 32,
                             height: .infinity)
           
           let boundingBox = text.boundingRect(
               with: size,
               options: .usesLineFragmentOrigin,
               attributes: [.font: uiFont],
               context: nil
           )
           
           updateHeight(from: boundingBox.height)
       }
       
       private func updateHeight(from contentHeight: CGFloat) {
           let newHeight = min(max(contentHeight + 20, minHeight), maxHeight)
           dynamicHeight = newHeight + (cornerRadius * 2)
       }
}

#Preview {
    
    @FocusState var isFocused: Bool
    
    CustomTextEditor(
        text: .constant("Type here"),
        isFocused: $isFocused,
        placeholder: Constants.typeHere,
        cornerRadius: 5,
        placeholderColor: AppColor.blackColor,
        textColor: AppColor.greenColor,
        backgroundColor: AppColor.clearColor,
        strokeColor: AppColor.clearColor,
        uiFont: AppFont.regular.uiFont(size: 13),
        minHeight: 10,
        maxHeight: 70
    )
}
