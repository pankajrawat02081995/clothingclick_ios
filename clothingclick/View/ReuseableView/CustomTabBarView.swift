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
                    
                    VStack {
                        Text(title(tab))
                            .foregroundColor(selectedTab == tab ? .black : .gray)
                        
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(selectedTab == tab ? .black : .clear)
                    }
                    .onTapGesture {
                        onSelect(tab)
                    }
                }
            }
        }
    }
}

