//
//  StatusToggleView.swift
//  clothingclick
//
//  Created by DavidBisht on 12/05/26.
//

import SwiftUI

struct StatusToggleView: View {

    let title: String
    let subtitle: String

    @Binding var isOn: Bool

    var body: some View {
        HStack(alignment: .top, spacing: 12) {

            Toggle("", isOn: $isOn)
                .labelsHidden()

            VStack(alignment: .leading, spacing: 4) {

                Text(title)
                    .font(.subheadline)
                    .fontWeight(.medium)

                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
    }
}
