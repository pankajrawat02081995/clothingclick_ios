//
//  SubCategoryView.swift
//  clothingclick
//
//  Created by DavidBisht on 01/05/26.
//

import SwiftUI

struct SubCategoryView: View {
    
    @StateObject var vm: SubCategoryViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        SelectionListView(
            title: vm.category.title,
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
        .onAppear() {
            vm.getSubCategoies()
        }
    }
    
}

//#Preview {
//    SubCategoryView()
//}
