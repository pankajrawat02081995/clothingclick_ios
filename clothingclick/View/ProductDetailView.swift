//
//  ProductDetailView.swift
//  clothingclick
//
//  Created by DavidBisht on 22/04/26.
//

import SwiftUI

struct ProductDetailView: View {
    
    var product: Product
    
    @State private var isActiveViewOnMap: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    productImage
                    productInfo
                        .padding(.horizontal)
                    CustomDivider(color: AppColor.borderColor, lineWidth: 1)
                    descriptionView
                        .padding(.horizontal)
                    CustomDivider(color: AppColor.borderColor, lineWidth: 1)
                    sellerView
                        .padding(.horizontal)
                    CustomDivider(color: AppColor.borderColor, lineWidth: 1)
                    moreFromSeller
                        .padding(.leading)
                    CustomDivider(color: AppColor.borderColor, lineWidth: 1)
                    recentlyViewed
                        .padding(.leading)

                }
                .padding(0)
                .padding(.bottom)
            }
            CustomDivider(color: AppColor.borderColor, lineWidth: 1)
            bottomBar
        }
        .navigationDestination(isPresented: $isActiveViewOnMap) {
            LocationView()
        }
        .customNavigationBar(
            config:NavBarConfig(
                title: product.name,
                font: AppFont.medium.font(size: 13.0),
                
                leading: NavBarItem(
                    title: "",
                    font: AppFont.medium.font(size: 13.0, relativeTo: .title),
                    image: "back",
                    isSystemImage: false,
                    action: {
                        print("back tapped")
                    }
                ),
                
                trailing: [NavBarItem(
                    title: "",
                    font: AppFont.medium.font(size: 13.0, relativeTo: .title),
                    image: "share",
                    isSystemImage: false,
                    action: {
                        print("share tapped")
                    }
                )]
            )
        )

    }
    
    private var productImage: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: URL(string: "")) { image in
                image
                    .resizable()
                    .aspectRatio(169/182, contentMode: .fit)
                    .frame(maxWidth: .infinity)
            } placeholder: {
                Image(.mfootwear)
                    .resizable()
                    .aspectRatio(169/182, contentMode: .fit)
                    .frame(maxWidth: .infinity)
            }

            
            
            HStack(spacing: 4) {
                ForEach(0..<4) { _ in
                    Circle()
                        .frame(width: 6, height: 6)
                        .foregroundColor(.gray.opacity(0.5))
                }
            }
            .padding(8)
        }
    }
    
    private var productInfo: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            Text(product.name)
                .font(AppFont.medium.font(size: 20))
                .foregroundStyle(AppColor.blackColor)
            Text("$\(product.price)")
                .font(AppFont.semibold.font(size: 25.0))
                .foregroundStyle(AppColor.blackColor)
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Size")
                        .font(AppFont.medium.font(size: 13))
                        .foregroundStyle(AppColor.darkGrayTextColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(product.size)")
                        .font(AppFont.regular.font(size: 15))
                        .foregroundStyle(AppColor.blackColor)
                    
                }
                .frame(maxWidth: .infinity)
                VStack(alignment: .leading, spacing: 6) {
                    Text("Condition")
                        .font(AppFont.medium.font(size: 13))
                        .foregroundStyle(AppColor.darkGrayTextColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(product.condition)")
                        .font(AppFont.regular.font(size: 15))
                        .foregroundStyle(AppColor.blackColor)
                }
                .frame(maxWidth: .infinity)
                VStack(alignment: .leading, spacing: 6) {
                    Text("Category")
                        .font(AppFont.medium.font(size: 13))
                        .foregroundStyle(AppColor.darkGrayTextColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\("Footwares")")
                        .font(AppFont.regular.font(size: 15))
                        .foregroundStyle(AppColor.blackColor)
                }
                .frame(maxWidth: .infinity)
            }
            
            Text(product.location)
                .font(AppFont.medium.font(size: 20.0))
                .foregroundStyle(AppColor.grayTextColor)
        }
        
    }
    
    private var descriptionView: some View {
        Text(product.description)
            .font(AppFont.regular.font(size: 15))
            .foregroundStyle(AppColor.grayTextColor)
    }
    
    private var sellerView: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            Text(Constants.seller)
                .font(AppFont.medium.font(size: 20))
                .foregroundStyle(AppColor.blackColor)
            
            HStack {
                AsyncImage(url: URL(string: "")) { image in
                    Image(product.sellerImage)
                        .resizable()
                        .frame(width: 57, height: 57)
                        .clipShape(Circle())
                } placeholder: {
                    Image(product.sellerImage)
                        .resizable()
                        .frame(width: 57, height: 57)
                        .background(AppColor.borderColor)
                        .clipShape(Circle())
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(product.sellerName)
                        .font(AppFont.medium.font(size: 15))
                        .foregroundStyle(AppColor.blackColor)
                    Text(product.sellerName+"· 560 \(Constants.posts.lowercased())")
                        .font(AppFont.medium.font(size: 13))
                        .foregroundStyle(AppColor.darkGrayTextColor)
                    HStack(alignment: .center, spacing: 2) {
                        Image(.star)
                        
                        Text("4.9 (9 \(Constants.reviews)")
                            .font(AppFont.medium.font(size: 10))
                            .foregroundStyle(AppColor.darkGrayTextColor)
                    }
                   
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
            }
            .padding()
            .background(AppColor.lightGrayColor)
        }
    }
    
    private var moreFromSeller: some View {
        productSection(title: Constants.moreFromSeller)
    }

    private var recentlyViewed: some View {
        productSection(title: Constants.recentlyViewed)
    }
    
    private func productSection(title: String) -> some View {
        VStack(alignment: .leading) {
            
            Text(title)
                .font(AppFont.medium.font(size: 20))
                .foregroundStyle(AppColor.blackColor)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(Product.mockData) { item in
                        VStack(alignment: .leading) {
                            AsyncImage(url: URL(string: "")) { image in
                                Image(item.image)
                                    .resizable()
                                    .frame(width: 144, height: 157)
                                    .border(AppColor.borderColor, width: 1)
                            } placeholder: {
                                Image(item.image)
                                    .resizable()
                                    .frame(width: 144, height: 157)
                                    .border(AppColor.borderColor, width: 1)
                            }

                           
                            
                            Text(item.name)
                                .font(AppFont.regular.font(size: 13))
                                .foregroundStyle(AppColor.blackColor)
                            
                            Text("$\(item.price)")
                                .font(AppFont.medium.font(size: 15))
                                .foregroundStyle(AppColor.blackColor)
                        }
                    }
                }
                .padding(.trailing)
            }
        }
    }
    
    private var bottomBar: some View {
        HStack {
            
            Button(action: {}) {
                HStack {
                    Image(.chat)
                    Text(Constants.chat)
                        .font(AppFont.medium.font(size: 15))
                        .foregroundStyle(AppColor.whiteColor)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(AppColor.blackColor)
                .foregroundColor(AppColor.whiteColor)
                .cornerRadius(8)

            }
            
            Button(action: {
                isActiveViewOnMap = true
            }) {
                HStack {
                    Image(.viewOnMap)
                    Text(Constants.viewOnMap)
                        .font(AppFont.medium.font(size: 15))
                        .foregroundStyle(AppColor.whiteColor)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(AppColor.blackColor)
                .foregroundColor(AppColor.whiteColor)
                .cornerRadius(8)
            }
        }
        .padding()
        .background(Color.white)
    }
}

#Preview {
    ProductDetailView(product: Product.sample)
}
