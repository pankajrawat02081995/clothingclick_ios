//
//  PriceView.swift
//  clothingclick
//
//  Created by DavidBisht on 01/05/26.
//

import SwiftUI

enum TextFieldType: Hashable {
    case minPrice
    case maxPrice
    
    func getValue() -> String {
        switch self {
        case .minPrice:
            return "Min"
        case .maxPrice:
            return "Max"
        }
    }
}

struct PriceView: View {
    
    @Environment(\.dismiss) var dismiss
    @State private var minPrice: String = ""
    @State private var maxPrice: String = ""

    @State private var selectedTextField: TextFieldType?
    @FocusState var focusedMaxPriceField: Bool
    @FocusState var focusedMinPriceField: Bool
    
    var body: some View {
        VStack {
            PriceTextFieldsView
            SelectionListView(
                title: Constants.seller,
                items: [
                    SelectableItem(title: "Under $25"),
                    SelectableItem(title: "Under $50"),
                    SelectableItem(title: "Under $75"),
                    SelectableItem(title: "Under $100"),
                    SelectableItem(title: "Under $200")
                ],
                isSingleSelection: true,
                onApply: { selectedItems in
                    if selectedItems.isEmpty {
                        print("Selected: None")
                    } else {
                        let titles = selectedItems.map { $0.title }.joined(separator: ", ")
                        print("Selected:", titles)
                    }
                }) { selectedItem in
                    let price = selectedItem.title.filter { $0.isNumber }
                    
                    print("price: \(price)")
                    print("selectedTextField: \(selectedTextField)")
                    if selectedTextField == .minPrice {
                        self.minPrice = price
                    } else if selectedTextField == .maxPrice {
                        self.minPrice = price
                    }
                    
                }
        }
    }
    
    private var PriceTextFieldsView: some View {
        HStack(spacing: 10) {
            PriceTextFieldView(
                placeholder: "0",
                text: $minPrice,
                type: .minPrice,
                keyboardType: .numberPad,
                selectedTextField: $selectedTextField,
                focusedField: $focusedMinPriceField
            )
            PriceTextFieldView(
                placeholder: "0",
                text: $maxPrice,
                type: .maxPrice,
                keyboardType: .numberPad,
                selectedTextField: $selectedTextField,
                focusedField: $focusedMaxPriceField
            )
        }
        .padding()
    }
    
}

//#Preview {
//    PriceView()
//}
