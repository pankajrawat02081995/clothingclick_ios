//
//  SortView.swift
//  clothingclick
//
//  Created by DavidBisht on 01/05/26.
//

import SwiftUI

struct SortView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        SelectionListView(
            title: Constants.style,
            items: [
                SelectableItem(title: "Date: New- Old"),
                SelectableItem(title: "Date: Old- New"),
                SelectableItem(title: "Price: Low - High"),
                SelectableItem(title: "Price: High - Low"),
                SelectableItem(title: "Trending")
            ],
            isSingleSelection: true,
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
    SortView()
}
