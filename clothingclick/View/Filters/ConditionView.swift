//
//  ConditionView.swift
//  clothingclick
//
//  Created by DavidBisht on 01/05/26.
//

import SwiftUI

struct ConditionView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        SelectionListView(
            title: Constants.condition,
            items: [
                SelectableItem(title: "New / Never Worn"),
                SelectableItem(title: "Gently Used"),
                SelectableItem(title: "Used"),
                SelectableItem(title: "Very Worn")
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
    ConditionView()
}
