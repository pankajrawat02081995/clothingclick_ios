//
//  SellerView.swift
//  clothingclick
//
//  Created by DavidBisht on 01/05/26.
//

import SwiftUI

struct SellerView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        SelectionListView(
            title: Constants.seller,
            items: [
                SelectableItem(title: "Individual Sellers"),
                SelectableItem(title: "Stores")
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
    SellerView()
}
