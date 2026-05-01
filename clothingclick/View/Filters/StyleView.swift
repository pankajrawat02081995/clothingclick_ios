//
//  StyleView.swift
//  clothingclick
//
//  Created by DavidBisht on 30/04/26.
//

import SwiftUI

struct StyleView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        SelectionListView(
            title: Constants.style,
            items: [
                SelectableItem(title: "Streetwear"),
                SelectableItem(title: "Vintage"),
                SelectableItem(title: "Casual"),
                SelectableItem(title: "Formal"),
                SelectableItem(title: "Athletic"),
                SelectableItem(title: "Designer")
            ],
            onApply: { selectedItems in
                if selectedItems.isEmpty {
                    print("Selected: None")
                } else {
                    let titles = selectedItems.map { $0.title }.joined(separator: ", ")
                    print("Selected:", titles)
                }
            }
        )
    }
    
}
#Preview {
    StyleView()
}
