//
//  SellSecondView.swift
//  clothingclick
//
//  Created by DavidBisht on 08/05/26.
//

import SwiftUI

struct SellSecondView: View {
    
    @Environment(\.dismiss) var dismiss
    @State var department: String
    @State var category: String
    @State var subcategory: String
    
    let sizes: [String] = ["XS","S","M","L","XL","XXL"]
    let conditions: [String] = ["New / Never Worn","Gently Used","Used","Very Worn"]
    let colors: [ColorDetail] =  [
        ColorDetail(id: "1", hexCode: "#000000", name: "Black"),
        ColorDetail(id: "2", hexCode: "#808080", name: "Grey"),
        ColorDetail(id: "3", hexCode: "#FFFFFF", name: "White"),
        ColorDetail(id: "4", hexCode: "#FF8C00", name: "Orange"),
        ColorDetail(id: "5", hexCode: "#FF0000", name: "Red"),
        ColorDetail(id: "6", hexCode: "#0000FF", name: "Blue"),
        ColorDetail(id: "7", hexCode: "#00C853", name: "Green"),
        ColorDetail(id: "8", hexCode: "#FFEA00", name: "Yellow"),
        ColorDetail(id: "9", hexCode: "#8B4513", name: "Brown"),
        ColorDetail(id: "10", hexCode: "#FF66FF", name: "Pink"),
        ColorDetail(id: "11", hexCode: "#F5DEB3", name: "Beige"),
        ColorDetail(id: "12", hexCode: "#8A2BE2", name: "Purple"),
        ColorDetail(id: "13", hexCode: "#6B8E23", name: "Camo"),
        ColorDetail(id: "14", hexCode: "#FF69B4", name: "Multicolor & Tyedye")
    ]
    
    @State private var selectedSize: String?
    @State private var selectedCondition: String?
    @State private var selectedColors: Set<ColorDetail> = []
    @State private var isActiveSellAddDetailsView: Bool = false
    
    var validate: Bool {
        selectedSize != nil &&
        selectedCondition != nil &&
        !selectedColors.isEmpty
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ScrollViewReader { proxy in
                    ScrollView {
                        VStack(spacing: 20) {
                            sizeSection
                                .padding(.horizontal)
                            conditionSection
                                .padding(.horizontal)
                            colorSection
                        }
                        .padding(.vertical)
                    }
                }
                CustomDivider(color: AppColor.borderColor, lineWidth: 1)
                saveButton
            }
        }
        .navigationDestination(isPresented: $isActiveSellAddDetailsView, destination: {
            SellAddDetailsView(department: department, category: category, subcategory: subcategory, size: selectedSize ?? "", condition: selectedCondition ?? "", colors: colors.map({$0.hexCode}))
        })
        .customNavigationBar(
            config:NavBarConfig(
                title: Constants.sell,
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
                    title: nil,
                    font: AppFont.medium.font(size: 10, relativeTo: .title),
                    image: "cross",
                    isSystemImage: false,
                    action: {
                        resetSelection()
                    }
                )]
            )
        )
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar(.hidden, for: .tabBar)
    }
    
    private func resetSelection() {
        selectedSize = nil
        selectedCondition = nil
        selectedColors.removeAll()
    }
    
    private var sizeSection: some View {
        SizeCategoryView(
            title: Constants.size,
            titleFont: AppFont.medium.font(size: 17),
            sizes: sizes,
            icon: nil,
            isSystemImage: false,
            selectedSize: selectedSize,
            strokeColors: nil
        ) { size in
            selectedSize = size
        }
    }
    
    private var conditionSection: some View {
        grid(
            title: Constants.condition,
            items: conditions,
            selectedItem: selectedCondition,
            columns: [GridItem(),GridItem()],
            itemTitle: { $0 }
        ) { condition in
            selectedCondition = condition
        }
    }
    
    private var colorSection: some View {
        VStack(alignment: .leading) {
            Text(Constants.color)
                .font(AppFont.medium.font(size: 17))
                .foregroundStyle(AppColor.blackColor)
                .padding(.horizontal)
            LazyVGrid(columns: [GridItem()]) {
                ForEach(colors, id: \.self) { item in
                    colorCardView(item) { color in
                        if selectedColors.contains(color) {
                            selectedColors.remove(color)
                        } else {
                            selectedColors.insert(color)
                        }
                    }
                }
            }
        }
    }
    
    
    private func grid<T: Hashable>(
        title: String,
        items: [T],
        selectedItem: T?,
        columns: [GridItem],
        numberOfLines: Int? = nil,
        itemTitle: @escaping (T) -> String,
        action: @escaping (T) -> Void
    ) -> some View {

        VStack(alignment: .leading) {

            Text(title)
                .font(AppFont.medium.font(size: 17))
                .foregroundStyle(AppColor.blackColor)

            LazyVGrid(columns: columns) {

                ForEach(items, id: \.self) { item in

                    let isSelected = selectedItem == item
                    
                    Button {
                        action(item)
                    } label: {
                        
                        Text(itemTitle(item))
                            .font(AppFont.regular.font(size: 13))
                            .foregroundStyle(
                                isSelected
                                ? AppColor.whiteColor
                                : AppColor.blackColor
                            )
                            .lineLimit(numberOfLines)
                            .padding(14)
                            .frame(maxWidth: .infinity)
                            .background(
                                isSelected
                                ? AppColor.blackColor
                                : AppColor.clearColor
                            )
                            .cornerRadius(5)
                            .overlay {
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(
                                        isSelected
                                        ? AppColor.blackColor
                                        : AppColor.borderColor,
                                        lineWidth: 1
                                    )
                            }
                    }
                    
                }
            }
        }
    }
    
    @ViewBuilder
    func colorCardView(_ item: ColorDetail, action: @escaping (ColorDetail) -> Void) -> some View {
        VStack(spacing: 0) {
            Button {
                action(item)
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
                        .foregroundColor(selectedColors.contains(item) ? AppColor.blackColor : AppColor.grayColor)
                }
            }
            .padding(.horizontal)
            .padding(.bottom)
            .padding(.top,10)
            CustomDivider(color: AppColor.borderColor, lineWidth: 1)
        }
    }
    
    private var saveButton: some View {
        Button(action: {
            if validate {
                isActiveSellAddDetailsView = true
            }
        }) {
            Text(Constants.save)
                .frame(maxWidth: .infinity)
                .padding()
                .background(validate ? AppColor.blackColor : AppColor.darkGrayColor)
                .font(AppFont.medium.font(size: 15.0))
                .foregroundColor(AppColor.whiteColor)
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .fill(AppColor.clearColor)
                        .stroke(validate ? AppColor.blackColor : AppColor.darkGrayColor, lineWidth: 1)
                )
        }
        .padding()
    }
    
}

//#Preview {
//    SellSecondView()
//}
