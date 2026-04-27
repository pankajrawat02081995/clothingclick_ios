//
//  ProductImageViewer.swift
//  clothingclick
//
//  Created by DavidBisht on 22/04/26.
//

import SwiftUI

struct ProductImageViewer: View {
    
    var images: [String]
    
    @State var selectedIndex = 0
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            TabView(selection: $selectedIndex) {
                ForEach(images.indices, id: \.self) { index in
                    AsyncImage(url: URL(string: images[index])) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .tag(index)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.black)
                    } placeholder: {
                        Image(systemName: "photo.on.rectangle.angled")
                            .resizable()
                            .scaledToFit()
                            .tag(index)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.black)
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            VStack {
                Spacer()
                pageIndicator
            }
        }
        .customNavigationBar(
            config:NavBarConfig(
                title: Constants.AppName,
                font: AppFont.medium.font(size: 13.0),
                tint: AppColor.whiteColor,

                leading: NavBarItem(
                    title: "",
                    font: AppFont.medium.font(size: 13.0, relativeTo: .title),
                    image: "back",
                    isSystemImage: false,
                    tint: AppColor.whiteColor,
                    action: {
                        print("back tapped")
                        self.dismiss()
                    }
                ),

                trailing: [NavBarItem(
                    title: "",
                    font: AppFont.medium.font(size: 13.0, relativeTo: .title),
                    image: "share",
                    isSystemImage: false,
                    tint: AppColor.whiteColor,
                    action: {
                        print("share tapped")
                    }
                )]
            )
        )
    }
    
    private var pageIndicator: some View {
        HStack(spacing: 6) {
            ForEach(images.indices, id: \.self) { index in
                Circle()
                    .fill(index == selectedIndex ? Color.white : Color.gray)
                    .frame(width: 6, height: 6)
            }
        }
        .padding(.bottom, 20)
    }
}

#Preview {
    ProductImageViewer(images: [])
}
