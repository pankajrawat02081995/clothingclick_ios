//
//  FilterView.swift
//  clothingclick
//
//  Created by DavidBisht on 30/04/26.
//

import SwiftUI

struct FilterView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm = FilterViewModel(items: [
        FilterItem(title: "My Sizes", type: .toggle(isOn: true), key: .mySizes),
        FilterItem(title: "Department", type: .navigation(value: "Menswear"), key: .department),
        FilterItem(title: "Category", type: .navigation(value: nil), key: .category),
        FilterItem(title: "Size", type: .navigation(value: "S,S,28,M,S"), key: .size),
        FilterItem(title: "Style", type: .navigation(value: nil), key: .style),
        FilterItem(title: "Brand Name", type: .navigation(value: nil), key: .brandName),
        FilterItem(title: "Color", type: .navigation(value: nil), key: .color),
        FilterItem(title: "Condition", type: .navigation(value: nil), key: .condition),
        FilterItem(title: "Seller", type: .navigation(value: nil), key: .seller),
        FilterItem(title: "Price", type: .navigation(value: nil), key: .price),
        FilterItem(title: "Distance", type: .navigation(value: nil), key: .distance),
        FilterItem(title: "Sort", type: .navigation(value: nil), key: .sort)
    ])
    
    var body: some View {
        VStack{
            FilterCardView(viewModel: vm)
        }
        .customNavigationBar(
            config: NavBarConfig(
                title: Constants.filter,
                font: AppFont.medium.font(size: 15),
                leading: NavBarItem(
                    title: nil,
                    font: AppFont.medium.font(size: 13),
                    image: "back",
                    isSystemImage: false,
                    tint: AppColor.blackColor,
                    action: {
                        dismiss()
                    }
                ),
                trailing: [
                    NavBarItem(
                        title: Constants.clearAll,
                        font: AppFont.medium.font(size: 10),
                        image: nil,
                        isSystemImage: false,
                        tint: AppColor.blackColor,
                        action: {
                            vm.clearAll()
                        }
                    ),
                ]
            )
        )
        .toolbar(.hidden, for: .tabBar)
    }
    
}

//#Preview {
//    FilterScreen()
//}
