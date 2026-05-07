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
    @Environment(\.dismiss) var dismiss
    @State var banners: [Banner] = []
    @State var currentBanner: Int = 0
    @State var isActiveBuyNow: Bool = true
    @State private var isActiveBuyNowView: Bool = false
    @State private var isReadyToMakeADeal: Bool = false
    @State private var targetFrame: CGRect = .zero
    @State private var showOverlay = false
    @State private var position: InfoPosition = .bottom
    
    
    var body: some View {
        ZStack{
            VStack(spacing: 0) {
                CustomDivider(color: AppColor.borderColor, lineWidth: 1)
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        
                        if banners.count > 0 {
                            productSlides
                            //                            .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width+((UIScreen.main.bounds.size.width*34.6)/100)) // base on figma
                                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width-((UIScreen.main.bounds.size.width*20)/100)) // base on old app
                        }
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
            .onAppear() {
                banners = Banner.sample
            }
            
            if showOverlay {
//                InfoOverlayView(
//                    title: "Ready to make a deal?",
//                    subtitle: "This is a fully custom SwiftUI overlay with a directional tail.",
//                    buttonTitle: "Got it",
//                    position: position,
//                    targetFrame: targetFrame
//                ) {
//                    withAnimation {
//                        showOverlay = false
//                    }
//                }
            }
        }
        .navigationDestination(isPresented: $isActiveViewOnMap) {
            LocationView()
        }
        .navigationDestination(isPresented: $isActiveBuyNowView) {
            BuyNowView()
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
                        dismiss()
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
    
    private var productSlides: some View {
        SlideShowView(
            items: banners,
            autoScroll: true,
            interval: 3.0,
            currentIndex: $currentBanner,
            indexDisplayMode: .never,
            customIndexDisplayMode: true
        ) { item in
            NavigationLink {
                let images = banners.map({ $0.imageUrl })
                if images.count > 0 {
                    ProductImageViewer(images: images, selectedIndex: currentBanner)
                }
            } label: {
                productImage(banner: banners[currentBanner])
            }
        }
    }
    
    private func productImage(banner: Banner) -> some View {
            GeometryReader { geo in
                ZStack(alignment: .center) {
                    AsyncImage(url: URL(string: banner.imageUrl)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        Image(systemName: "photo.on.rectangle.angled")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(AppColor.blackColor)
                    }
                }
                .frame(width: geo.size.width, height: geo.size.height)
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
                    Text(Constants.size)
                        .font(AppFont.medium.font(size: 13))
                        .foregroundStyle(AppColor.darkGrayTextColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(product.size)")
                        .font(AppFont.regular.font(size: 15))
                        .foregroundStyle(AppColor.blackColor)
                    
                }
                .frame(maxWidth: .infinity)
                VStack(alignment: .leading, spacing: 6) {
                    Text(Constants.condition)
                        .font(AppFont.medium.font(size: 13))
                        .foregroundStyle(AppColor.darkGrayTextColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(product.condition)")
                        .font(AppFont.regular.font(size: 15))
                        .foregroundStyle(AppColor.blackColor)
                }
                .frame(maxWidth: .infinity)
                VStack(alignment: .leading, spacing: 6) {
                    Text(Constants.category)
                        .font(AppFont.medium.font(size: 13))
                        .foregroundStyle(AppColor.darkGrayTextColor)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\("Footwares")")
                        .font(AppFont.regular.font(size: 15))
                        .foregroundStyle(AppColor.blackColor)
                }
                .frame(maxWidth: .infinity)
            }
            
            HStack(alignment: .top) {
                NavigationLink {
                    MapView()
                } label: {
                    Text(product.location)
                        .font(AppFont.medium.font(size: 20.0))
                        .foregroundStyle(AppColor.blueColor)
                }
                Spacer()
                Image(.clock)
                Text("1 Week Ago")
                    .font(AppFont.medium.font(size: 13.0))
                    .foregroundStyle(AppColor.blackColor)
            }
            .padding(.top, 10)
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
                    NavigationLink {
                        ReviewsView()
                    } label: {
                        HStack(alignment: .center, spacing: 2) {
                            Image(.star)
                            Text("4.9 (9 \(Constants.reviews))")
                                .font(AppFont.medium.font(size: 10))
                                .foregroundStyle(AppColor.darkGrayTextColor)
                        }
                    }
                }
                
                Spacer()
                NavigationLink(destination: ProfileView()) {
                    Image(.rightArrow)
                }
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
            
            if isActiveBuyNow {
                Button(action: {
                    isActiveBuyNowView = true
                }) {
                    HStack {
                        Image(.cart)
                        Text(Constants.buyNow)
                            .font(AppFont.medium.font(size: 15))
                            .foregroundStyle(AppColor.whiteColor)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(AppColor.blackColor)
                    .foregroundColor(AppColor.whiteColor)
                    .cornerRadius(5)
                    
                }
            } else {
                Button(action: {
                    if isReadyToMakeADeal == false {
                        showOverlay = true
                    }
                    isReadyToMakeADeal = true
                }) {
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
                    .cornerRadius(5)
                    
                }
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
                .cornerRadius(5)
            }
        }
        .padding()
        .background(Color.white)
    }
}

#Preview {
    ProductDetailView(product: Product.sample)
}
