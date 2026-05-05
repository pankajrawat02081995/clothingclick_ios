//
//  ColorView.swift
//  clothingclick
//
//  Created by DavidBisht on 01/05/26.
//

import SwiftUI

struct ColorView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm = ColorViewModel()
    @FocusState var searchFocusState: Bool
    @State private var selectedItems: Set<ColorDetail> = []
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 0) {
                List(vm.colors) { item in
                    colorCardView(item)
                        .listRowSeparator(.hidden)
                        .listRowInsets(EdgeInsets())
                }
                .listStyle(.plain)
                // Bottom Button
                Button(action: {
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
            .onAppear()
            {
                vm.mockData()
            }
            .customNavigationBar(
                config:
                    NavBarConfig(
                        title: Constants.colors,
                        font: AppFont.medium.font(size: 15.0),
                        leading: NavBarItem(
                            title: "",
                            font: AppFont.medium.font(size: 13.0, relativeTo: .title),
                            image: "back",
                            isSystemImage: false,
                            tint: AppColor.blackColor,
                            action: {
                                self.dismiss()
                            }
                        ),
                        trailing: [NavBarItem(
                            title: Constants.clearAll,
                            font: AppFont.medium.font(size: 10, relativeTo: .title),
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
    }
    
    @ViewBuilder
    func colorCardView(_ item: ColorDetail) -> some View {
        VStack(spacing: 0) {
            Button {
                toggleSelection(item)
            } label: {
                HStack {
                    Circle()
                        .fill(Color.init(hex: item.hexCode))
                        .stroke(AppColor.borderColor, lineWidth: 1)
                        .frame(width: 17, height: 17)
                    Text(item.name)
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
    }
    
    private func toggleSelection(_ item: ColorDetail) {
        if selectedItems.contains(item) {
            selectedItems.remove(item)
        } else {
            selectedItems.insert(item)
        }
    }
    
}

#Preview {
    ColorView()
}
