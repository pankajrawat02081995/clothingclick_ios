//
//  SelectionListView.swift
//  clothingclick
//
//  Created by DavidBisht on 30/04/26.
//

import SwiftUI

struct SelectionListView: View {
    let title: String
    let items: [SelectableItem]
    var isSingleSelection: Bool = false
    var onApply: (([SelectableItem]) -> Void)? = nil
    var onSelection: ((SelectableItem) -> Void)? = nil
    @Environment(\.dismiss) private var dismiss

    @State private var selectedItems: Set<SelectableItem> = []
    
    var body: some View {
        VStack(spacing: 0) {

            // List
            List(items) { item in
                VStack(spacing: 0) {
                    Button {
                        if isSingleSelection == false {
                            toggleSelection(item)
                        } else {
                            selectedItems = [item]
                        }
                        onSelection?(item)
                    } label: {
                        HStack {
                            Text(item.title)
                                .font(AppFont.regular.font(size: 15))
                                .foregroundColor(AppColor.blackColor)
                            
                            Spacer()
                            
                            Image(.roundCheck)
                                .renderingMode(.template)
                                .foregroundColor(selectedItems.contains(item) ? AppColor.blackColor : AppColor.grayColor)
                        }
                    }
                    .padding()
                    CustomDivider(color: AppColor.borderColor, lineWidth: 1)
                }
                .listRowInsets(EdgeInsets(.zero))
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)

            // Bottom Button
            Button(action: {
                onApply?(Array(selectedItems))
                dismiss()
            }) {
                Text("\(Constants.view) \(selectedItems.count) \(selectedItems.count <= 1 ? Constants.result : Constants.results)")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .font(AppFont.regular.font(size: 15))
                    .background(AppColor.blackColor)
                    .foregroundColor(AppColor.whiteColor)
                    .cornerRadius(5)
                    .padding()
            }
        }
        .customNavigationBar(
            config:NavBarConfig(
                title: title,
                font: AppFont.medium.font(size: 13.0),
                
                leading: NavBarItem(
                    title: nil,
                    font: AppFont.medium.font(size: 13.0, relativeTo: .title),
                    image: "back",
                    isSystemImage: false,
                    action: {
                        dismiss()
                    }
                ),
                
                trailing: [NavBarItem(
                    title: Constants.clearAll,
                    font: AppFont.medium.font(size: 13.0, relativeTo: .title),
                    image: nil,
                    isSystemImage: false,
                    action: {
                        selectedItems.removeAll()
                    }
                )]
            )
        )
        .toolbarBackground(.visible, for: .navigationBar)
    }
    
    
    private func toggleSelection(_ item: SelectableItem) {
        if selectedItems.contains(item) {
            selectedItems.remove(item)
        } else {
            selectedItems.insert(item)
        }
    }
}

//#Preview {
//    SelectionListView()
//}
