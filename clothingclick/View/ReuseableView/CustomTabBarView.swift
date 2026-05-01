//
//  CustomTabBarView.swift
//  clothingclick
//
//  Created by DavidBisht on 27/04/26.
//

import SwiftUI

struct CustomTabBarView<T: Hashable>: View {
    
    let tabs: [T]
    let selectedTab: T
    let title: (T) -> String
    let onSelect: (T) -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                ForEach(tabs, id: \.self) { tab in
                    VStack(spacing: 0) {
                        Text(title(tab))
                            .foregroundColor(selectedTab == tab ? AppColor.blackColor : AppColor.darkGrayColor)
                            .padding(10)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(selectedTab == tab ? AppColor.blackColor : AppColor.clearColor)
                    }
                    .onTapGesture {
                        onSelect(tab)
                    }
                }
            }
            Divider()
        }
    }
}

