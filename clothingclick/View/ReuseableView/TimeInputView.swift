//
//  TimeInputView.swift
//  clothingclick
//
//  Created by DavidBisht on 12/05/26.
//

import SwiftUI

struct TimeInputView: View {

    let placeholder: String
    @Binding var text: String

    var body: some View {
        TextField(placeholder, text: $text)
            .font(.caption)
            .keyboardType(.numberPad)
            .submitLabel(.done)
            .padding(.vertical, 10)
            .padding(.horizontal, 12)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(8)
            .onChange(of: text) { _, newValue in

                let numbers = newValue.filter { $0.isNumber }
                let limited = String(numbers.prefix(4))

                var formatted = ""

                if limited.count >= 1 {
                    formatted += String(limited.prefix(min(2, limited.count)))
                }

                if limited.count > 2 {
                    formatted += ":"
                    formatted += String(limited.suffix(limited.count - 2))
                }

                text = formatted

                // Validate HH
                let parts = formatted.split(separator: ":")

                if parts.count == 2 {

                    let hour = Int(parts[0]) ?? 0
                    let minute = Int(parts[1]) ?? 0

                    if hour > 23 {
                        text = "23:\(parts[1])"
                    }

                    if minute > 59 {
                        text = "\(parts[0]):59"
                    }
                }
            }
    }
}
