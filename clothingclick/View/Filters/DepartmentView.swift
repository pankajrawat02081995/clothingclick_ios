//
//  DepartmentView.swift
//  clothingclick
//
//  Created by DavidBisht on 01/05/26.
//

import SwiftUI

struct DepartmentView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        SelectionListView(
            title: Constants.department,
            items: [
                SelectableItem(title: Constants.menswear),
                SelectableItem(title: Constants.womenswear),
                SelectableItem(title: Constants.both)
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
    DepartmentView()
}
