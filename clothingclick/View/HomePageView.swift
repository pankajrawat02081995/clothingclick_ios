//
//  HomePageView.swift
//  clothingclick
//
//  Created by DavidBisht on 21/04/26.
//

import SwiftUI

struct HomePageView: View {
    let filters = ["Vintage", "Athletic", "Designer", "Street wear"]
        
        let products = Product.mockData
    @State var isBuyNow: Bool = false
    @State var selectedProduct: Product?
    @State var isActiveProductDetailView: Bool = false
    
    @State private var goToNotifications: Bool = false
    @State private var goToSelectLocation: Bool = false
    @State private var location: String = ""
    
    var leadingTitle: String {
        return location.isEmpty ? Constants.selectLocation : location
    }
        
        var body: some View {
                VStack(spacing: 0) {
                    CustomDivider(color: AppColor.borderColor)
                    VStack(alignment: .leading, spacing: 16
                    ) {
                        filterView
                        productGrid
                        Spacer()
                    }
                    .padding()
                    .navigationDestination(isPresented: $isActiveProductDetailView) {
                        if let product = selectedProduct {
                            ProductDetailView(
                                product: product,
                                isActiveBuyNow: isBuyNow
                            )
                        }
                    }
                }
                .padding(0.2)
                .navigationDestination(isPresented: $goToNotifications) {
                    NotificationsView()
                }
                .navigationDestination(isPresented: $goToSelectLocation) {
                    LocationView()
                }
                .customNavigationBar(
                    config:NavBarConfig(
                        title: Constants.AppName,
                        font: AppFont.medium.font(size: 13.0),
                        
                        leading: NavBarItem(
                            title: leadingTitle,
                            font: AppFont.medium.font(size: 13.0, relativeTo: .title),
                            image: "headerlocation",
                            isSystemImage: false,
                            action: {
                                if leadingTitle == Constants.selectLocation {
                                    goToSelectLocation = true
                                }
                            }
                        ),
                        
                        trailing: [NavBarItem(
                            title: "",
                            font: AppFont.medium.font(size: 13.0, relativeTo: .title),
                            image: "bell",
                            isSystemImage: false,
                            action: {
                                goToNotifications = true
                            }
                        )]
                    )
                )
           
        }
    
    @State private var selectedFilter = "Vintage"
    
    private var headerView: some View {
        HStack {
            
            HStack(spacing: 4) {
                Image(.headerlocation)
                Text("Toronto")
            }
            
            Spacer()
            
            Text("ClothingClick")
                .font(.headline)
            
            Spacer()
            
            Image(.bell)
        }
        .background(.yellow)
    }

    private var filterView: some View {
        VStack(alignment: .leading) {
            
            HStack {
                Text("Looking For?")
                    .foregroundStyle(AppColor.blackColor)
                    .font(AppFont.regular.font(size: 15.0))
                Spacer()
                Text("Filters")
                    .foregroundStyle(AppColor.blackColor)
                    .font(AppFont.regular.font(size: 13.0))
            }
            .padding(.bottom, 5)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(filters, id: \.self) { filter in
                        
                        Text(filter)
                            .font(AppFont.regular.font(size: 13.0))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 0)
                                    .stroke((selectedFilter == filter
                                            ? AppColor.blackColor
                                            : AppColor.borderColor), lineWidth: 1)
                            )
                            .background(
                                selectedFilter == filter
                                ? AppColor.blackColor
                                : AppColor.whiteColor
                            )
                            .foregroundColor(
                                selectedFilter == filter
                                ? AppColor.whiteColor
                                : AppColor.blackColor
                            )
                            .cornerRadius(0)
                            .onTapGesture {
                                selectedFilter = filter
                            }
                    }
                }
            }
        }
    }
    
    private var productGrid: some View {
        
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
                
        return ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Brwose")
                    .foregroundStyle(AppColor.blackColor)
                    .font(AppFont.regular.font(size: 17))
                LazyVGrid(columns: columns, spacing: 16) {
                    
                    ForEach(products) { product in
                        NavigationLink(destination: ProductDetailView(product: product, isActiveBuyNow: isBuyNow)) {
                            productCard(product)
                                .onTapGesture {
                                    selectedProduct = nil
                                    selectedProduct = product
                                    isBuyNow = product.image.isEmpty //add check for buy now with navigation
                                    isActiveProductDetailView = true
                                }
                        }
                    }
                }
            }
        }
    }
    
    private func productCard(_ product: Product) -> some View {
        
        VStack(alignment: .leading) {
            
            let url: URL? = URL(string: product.image)
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .aspectRatio(169.0 / 182.0, contentMode: .fit)
                    .clipped()
                    .cornerRadius(0)
            } placeholder: {
                Image(systemName: "photo.on.rectangle.angled")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 150)
                    .clipped()
                    .cornerRadius(0)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 0)
                    .stroke(AppColor.borderColor, lineWidth: 1.0)
            }
          
            HStack {
                Text(product.name)
                    .font(AppFont.regular.font(size: 13))
                    .foregroundStyle(AppColor.blackColor)
                Spacer()
                Image(.heart)
                    .padding(.top, 5)
            }
            
            Text("$\(product.price)")
                .font(AppFont.medium.font(size: 15))
                .foregroundStyle(AppColor.blackColor)

        }
    }
    
}




#Preview {
    HomePageView()
}
