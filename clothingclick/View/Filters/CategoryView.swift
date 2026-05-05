//
//  CategoryView.swift
//  clothingclick
//
//  Created by DavidBisht on 01/05/26.
//

import SwiftUI

struct CategoryView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject private var vm = FilterViewModel(items: [
        FilterItem(title: Constants.tops, type: .navigation(value: nil), key: .subCategory),
        FilterItem(title: Constants.bottoms, type: .navigation(value: nil), key: .subCategory),
        FilterItem(title: Constants.footwear, type: .navigation(value: nil), key: .subCategory),
        FilterItem(title: Constants.outerwear, type: .navigation(value: nil), key: .subCategory),
        FilterItem(title: Constants.jeans, type: .navigation(value: nil), key: .subCategory),
        FilterItem(title: Constants.accessories, type: .navigation(value: nil), key: .subCategory),
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
    }
    
}

#Preview {
    CategoryView()
}
